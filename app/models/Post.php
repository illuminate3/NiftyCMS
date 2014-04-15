<?php

class Post extends Eloquent {
	protected $guarded = array();

	public static $rules = [
								'title' => 'required|max:255',
								'summary' => 'required|max:512',
								'content' => 'required',
								'order' => 'integer',
								'link' => 'URL'
							];

	public function user()
	{
		return $this->belongsTo('User');
	}

	public function categories()
	{
		return $this->belongsToMany('Category');
	}

	public static function getPosts($type, $paginate)
	{
		$posts = '';

		switch ($type) {
			case "allNotDeleted":
				if ( isset($_GET['author']) ) {
					$posts = static::with('categories')->whereHas('user', function($query) { $query->whereId($_GET['author']); })->whereIsDeleted(0)->orderBy('order')->paginate( (int) $paginate );
				}
				elseif ( isset($_GET['category']) ) {
					$posts = static::with('user')->whereHas('categories', function($query) { $query->whereCategoryId($_GET['category']); })->whereIsDeleted(0)->orderBy('order')->paginate( (int) $paginate );
				}
				else {
					$posts = static::with('user')->with('categories')->whereIsDeleted(0)->orderBy('order')->paginate( (int) $paginate );
				}

				break;
		    case "published":
		        $posts = static::with('categories')->with('user')->whereIsDeleted(0)->whereIsOnline(1)->orderBy('order')->paginate( (int) $paginate );
		        break;
		    case "drafts":
		        $posts = static::with('categories')->with('user')->whereIsDeleted(0)->whereIsOnline(0)->orderBy('order')->paginate( (int) $paginate );
		        break;
		    case "deleted":
		        $posts = static::with('categories')->with('user')->whereIsDeleted(1)->orderBy('order')->paginate( (int) $paginate );
		        break;
		}

		return $posts;
	}

	public static function countPosts($type)
	{
		$num = 0;

		switch ($type) {
			case "allNotDeleted":
				$num = static::whereIsDeleted(0)->count();
				break;
		    case "published":
		        $num = static::whereIsDeleted(0)->whereIsOnline(1)->count();
		        break;
		    case "drafts":
		        $num = static::whereIsDeleted(0)->whereIsOnline(0)->count();
		        break;
		    case "deleted":
		        $num = static::whereIsDeleted(1)->count();
		        break;
		}

		return $num;
	}

	public static function getNotDeletedPostsNum( $minutes )
	{
		$allNotDeletedNum = Cache::remember('allNotDeletedNumPosts', $minutes, function()
		{
		    return static::countPosts('allNotDeleted');
		});	

		return $allNotDeletedNum;
	}

	public static function getPublishedPostsNum( $minutes )
	{
		$publishedNum = Cache::remember('publishedNumPosts', $minutes, function()
		{
		    return static::countPosts('published');
		});

		return $publishedNum;
	}

	public static function getDraftPostsNum( $minutes )
	{
		$draftsNum = Cache::remember('draftsNumPosts', $minutes, function()
		{
		    return static::countPosts('drafts');
		});

		return $draftsNum;
	}

	public static function getDeletedPostsNum( $minutes )
	{
		$deletedNum = Cache::remember('deletedNumPosts', $minutes, function()
		{
		    return static::countPosts('deleted');
		});

		return $deletedNum;
	}

	public static function withCategoriesFind($postId)
	{
		return static::with('categories')->find($postId);
	}

	public static function getSinglePost($slug)
	{
		return static::with('categories')->with('user')->whereIsDeleted(0)->whereIsOnline(1)->whereSlug($slug)->first();
	}


##################FRONTEND POSTS METHODS########################################
    public static function getFrontendPosts($orderBy, $limit, $paginate)
    {
    	$posts = static::with('categories')
    					->with('user')
    					->whereIsOnline(1)
    					->whereIsDeleted(0)
    					->orderBy($orderBy[0], $orderBy[1])
    					->take( (int) $limit )
    					->paginate( (int) $paginate );

    	return $posts;
    }

    public static function getFrontendPostsInCategory($category, $orderBy)
    {
    	$posts = static::whereHas('categories', function($query) use($category) { $query->whereName($category); })
    					->whereIsOnline(1)
    					->whereIsDeleted(0)
    					->orderBy($orderBy[0], $orderBy[1])
    					->get();

    	return $posts;
    }      

    public static function getFrontendPost( $slug )
    {
       $post =  static::with('user')
       				   ->whereIsOnline(1)
                       ->whereIsDeleted(0)
                       ->whereSlug($slug)
                       ->first();

        return $post;
    }

    public static function doSearch($term)
    {
        return static::with('categories')
                        ->whereIsOnline(1)
                        ->whereIsDeleted(0)
                        ->where( function($query) use($term) {
                            $query->where('title', 'like', "%$term%")
                                ->orWhere('summary', 'like', "%$term%")
                                ->orWhere('content', 'like', "%$term%");
                            })
                        ->get();        
    }    

}
