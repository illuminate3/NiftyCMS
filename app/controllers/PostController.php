<?php
use Carbon\Carbon;

class PostController extends BaseController {

	public function __construct()
	{
		$this->user = Sentry::getUser();
		$this->isAdmin = User::isAdmin( $this->user );
		$this->logged_in_for = $this->user->last_login->diffForHumans();
		$this->configs = Setting::getSiteSettings();
		$this->categorylist = Category::getCategoryList();
		$this->paginate = 100;
		$this->cacheMinutes = 30;
		$this->rules = Post::$rules;
		$this->activeParent = 'blog';	
		$this->thumbnailPath = Setting::getThumbnailPath();				
	}

	public function index()
	{
		$posts =  Post::getPosts( 'allNotDeleted', $this->paginate );
		$postsHtml = Jamesy\BackendPosts::getPostsHtml($posts, 'all');

		$allNotDeletedNum = Post::getNotDeletedPostsNum( $this->cacheMinutes );
		$publishedNum  = Post::getPublishedPostsNum( $this->cacheMinutes );
		$draftsNum = Post::getDraftPostsNum( $this->cacheMinutes );
		$deletedNum = Post::getDeletedPostsNum( $this->cacheMinutes );

		$nums = compact("allNotDeletedNum", "publishedNum", "draftsNum", "deletedNum");

        return View::make('backend.posts.index', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,   
        			'postsHtml' => $postsHtml,       			
        			'nums' => $nums, 
        			'type' => 'All', 
        			'links' => $posts->links(), 
        			'activeParent' => $this->activeParent,
        			'active' => 'allposts',
        			'links' => $posts->links('backend.pagination.nifty')
        		]);
	}

	public function published_posts()
	{
		$posts =  Post::getPosts( 'published', $this->paginate );
		$postsHtml = Jamesy\BackendPosts::getPostsHtml($posts, 'published');

		$allNotDeletedNum = Post::getNotDeletedPostsNum( $this->cacheMinutes );
		$publishedNum  = Post::getPublishedPostsNum( $this->cacheMinutes );
		$draftsNum = Post::getDraftPostsNum( $this->cacheMinutes );
		$deletedNum = Post::getDeletedPostsNum( $this->cacheMinutes );

		$nums = compact("allNotDeletedNum", "publishedNum", "draftsNum", "deletedNum");

        return View::make('backend.posts.index', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,  
        			'postsHtml' => $postsHtml,        			
        			'nums' => $nums,  
        			'type' => 'Published',
        			'links' => $posts->links(), 
        			'activeParent' => $this->activeParent,
        			'active' => 'allposts',
        			'links' => $posts->links('backend.pagination.nifty')
        		]);
		
	}

	public function draft_posts()
	{
		$posts =  Post::getPosts( 'drafts', $this->paginate );
		$postsHtml = Jamesy\BackendPosts::getPostsHtml($posts, 'drafts');

		$allNotDeletedNum = Post::getNotDeletedPostsNum( $this->cacheMinutes );
		$publishedNum  = Post::getPublishedPostsNum( $this->cacheMinutes );
		$draftsNum = Post::getDraftPostsNum( $this->cacheMinutes );
		$deletedNum = Post::getDeletedPostsNum( $this->cacheMinutes );

		$nums = compact("allNotDeletedNum", "publishedNum", "draftsNum", "deletedNum");

        return View::make('backend.posts.index', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,  
        			'postsHtml' => $postsHtml,        			
        			'nums' => $nums,  
        			'type' => 'Drafts',
        			'links' => $posts->links(), 
        			'activeParent' => $this->activeParent,
        			'active' => 'allposts',
        			'links' => $posts->links('backend.pagination.nifty')
        		]);
		
	}

	public function deleted_posts()
	{
		$posts =  Post::getPosts( 'deleted', $this->paginate );
		$postsHtml = Jamesy\BackendPosts::getPostsHtml($posts, 'deleted');

		$allNotDeletedNum = Post::getNotDeletedPostsNum( $this->cacheMinutes );
		$publishedNum  = Post::getPublishedPostsNum( $this->cacheMinutes );
		$draftsNum = Post::getDraftPostsNum( $this->cacheMinutes );
		$deletedNum = Post::getDeletedPostsNum( $this->cacheMinutes );

		$nums = compact("allNotDeletedNum", "publishedNum", "draftsNum", "deletedNum");

        return View::make('backend.posts.deleted', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,  
        			'postsHtml' => $postsHtml,        			
        			'nums' => $nums,  
        			'type' => 'Deleted',
        			'links' => $posts->links(), 
        			'activeParent' => $this->activeParent,
        			'active' => 'allposts',
        			'links' => $posts->links('backend.pagination.nifty')
        		]);
		
	}	

	public function create()
	{
		return View::make('backend.posts.new', [
					'categorylist' => $this->categorylist, 
					'user' => $this->user, 
					'isAdmin' => $this->isAdmin, 
					'logged_in_for' => $this->logged_in_for,
        			'activeParent' => $this->activeParent,
        			'active' => 'createpost',					
					'configs' => $this->configs,
					'thumbnailPath' => asset($this->thumbnailPath)
				]);
	}

	public function store()
	{
		$validation = Jamesy\MyValidations::validate( Input::all(), $this->rules );

		if($validation != NULL) {
			return Redirect::back()->withErrors($validation)->withInput();
		}

		else {
			Cache::flush();
			$title = Jamesy\Sanitiser::trimInput( Input::get('title') );
			$summary = Jamesy\Sanitiser::trimInput( Input::get('summary') );
			$content = Jamesy\Sanitiser::trimInput( Input::get('content') );
			$categories = Input::get('categories') == null ? [Category::first()->id] : Input::get('categories');
			$is_online = Input::get('is_online');

			$existingSlugs = Post::lists('slug');
			$slug = Jamesy\MyValidations::makeSlug( $existingSlugs, Str::slug($title) );

			$order = Input::get('order');
			if ( strlen($order) == 0 )
				$order = 0;			

			$post = new Post;
			$post->user_id = $this->user->id;
			$post->title = $title;
			$post->slug = $slug;
			$post->summary = $summary;
			$post->content = $content;
			$post->order = $order;
			if ( Input::get('link') ) $post->link = Input::get('link');
			if ( Input::get('featured_image') ) $post->featured_image = Input::get('featured_image');
			$post->is_online = $is_online;
			$post->save();

			$post->categories()->sync($categories);
			return Redirect::to('dashboard/blog')->withSuccess('New post created.');
		}
	}


	public function edit($id)
	{
		$post = Post::withCategoriesFind($id);

		return View::make('backend.posts.edit', [
					'categories' => $this->categorylist, 
					'user' => $this->user, 
					'isAdmin' => $this->isAdmin, 
					'logged_in_for' => $this->logged_in_for,
        			'activeParent' => $this->activeParent,
        			'active' => 'allposts',					
					'configs' => $this->configs,
					'post' => $post,
					'thumbnailPath' => asset($this->thumbnailPath)
				]);
	}

	public function update($id)
	{
		$validation = Jamesy\MyValidations::validate( Input::all(), $this->rules );

		if($validation != NULL) {
			return Redirect::back()->withErrors($validation)->withInput();
		}

		else {
			Cache::flush();

			$title = Jamesy\Sanitiser::trimInput( Input::get('title') );
			$summary = Jamesy\Sanitiser::trimInput( Input::get('summary') );
			$content = Jamesy\Sanitiser::trimInput( Input::get('content') );
			$categories = Input::get('categories') == null ? [Category::first()->id] : Input::get('categories');
			$is_online = Input::get('is_online');

			$order = Input::get('order');
			if ( strlen($order) == 0 )
				$order = 0;	

			$post = Post::find($id);
			$post->user_id = $this->user->id;
			$post->title = $title;
			$post->summary = $summary;
			$post->content = $content;
			$post->order = $order;
			if ( Input::get('link') ) $post->link = Input::get('link');
			if ( Input::get('featured_image') ) $post->featured_image = Input::get('featured_image');
			$post->is_online = $is_online;
			$post->save();

			$post->categories()->sync($categories);
			return Redirect::to('dashboard/blog')->withSuccess('Post updated.');
		}
	}

	public function bulk_publish()
	{
		$postIds = Input::get('posts');
		$published = 0;

		foreach ($postIds as $postId) {
			$post = Post::find($postId);
			$post->is_online = 1;
			$post->save();
			$published++;
		}

		Cache::flush();
		return Redirect::back()->withSuccess($published . ' ' . str_plural('post', $published) . ' published.');
	}	

	public function bulk_draft()
	{
		$postIds = Input::get('posts');
		$drafts = 0;

		foreach ($postIds as $postId) {
			$post = Post::find($postId);
			$post->is_online = 0;
			$post->save();
			$drafts++;
		}

		Cache::flush();
		return Redirect::back()->withSuccess($drafts . ' ' . str_plural('post', $drafts) . ' unpublished.');
	}	

	public function delete($id)
	{
		$post = Post::find($id);
		$post->is_deleted = 1;
		$post->save();

		Cache::flush();

		return Redirect::back()->withSuccess('Post moved to trash.');
	}

	public function bulk_delete()
	{
		$postIds = Input::get('posts'); 
		$deleted = 0;

		foreach ($postIds as $postId) {
			$post = Post::find($postId);
			$post->is_deleted = 1;
			$post->save();
			$deleted++;
		}

		Cache::flush();

		return Redirect::back()->withSuccess($deleted . ' ' . str_plural('post', $deleted) . ' moved to trash.');
	}

	public function restore($id)
	{
		$post = Post::find($id);
		$post->is_deleted = 0;
		$post->save();

		Cache::flush();

		return Redirect::back()->withSuccess('Post restored.');
	}

	public function bulk_restore()
	{
		$postIds = Input::get('posts'); 
		$restored = 0;

		foreach ($postIds as $postId) {
			$post = Post::find($postId);
			$post->is_deleted = 0;
			$post->save();
			$restored++;
		}

		Cache::flush();

		return Redirect::back()->withSuccess($restored . ' ' . str_plural('post', $restored) . ' restored.');
	}

	public function destroy($id)
	{
		$post = Post::find($id);
		$post->delete();

		Cache::flush();

		return Redirect::back()->withSuccess('Post deleted.');
	}

	public function bulk_destroy()
	{
		$postIds = Input::get('posts'); 

		Post::whereIn('id', $postIds)->delete();

		Cache::flush();

		return Redirect::back()->withSuccess(count($postIds) . ' ' . str_plural('post', count($postIds)) . ' permanently deleted.');
	}

}
