<?php
use Carbon\Carbon;

class DashboardController extends BaseController {

	public function __construct()
	{
		$this->thumbnailPath = Setting::getThumbnailPath();
		$this->paginate = 1000;
	}

	public function index()
	{
		$user = Sentry::getUser();
		$isAdmin = User::isAdmin( $user ); 
		$configs = Setting::first();
		$logged_in_for = $user->last_login->diffForHumans();

		$allPages = Page::countPages('allNotDeleted'); 
		$publishedPages = Page::countPages('published');
		$draftPages = Page::countPages('drafts');
		$deletedPages = Page::countPages('deleted'); 

		$allPosts = Post::countPosts('allNotDeleted'); 
		$publishedPosts = Post::countPosts('published');
		$draftPosts = Post::countPosts('drafts');
		$deletedPosts = Post::countPosts('deleted');	
		
		$users = User::getUsersWithContent( $exceptId = 1, $this->paginate );

		$numbers = [$allPages,$publishedPages,$draftPages,$deletedPages,$allPosts,$publishedPosts,$draftPosts,$deletedPosts,$users];

        return View::make('backend.index', [
    				'user' => $user, 
    				'isAdmin' => $isAdmin, 
    				'configs' => $configs, 
    				'logged_in_for' => $logged_in_for, 
    				'numbers' => $numbers,
        			'activeParent' => 'index',
        			'active' => 'index'
    			]);
	}

	public function profile()
	{
		$user = Sentry::getUser();
		$group = $user->getGroups()[0]; 
		$configs = Setting::first();	
		
		return View::make('backend.profile', ['user' => $user, 'group' => $group, 'configs' => $configs]);	
	}

	public function select_featured_image()
	{
		try {
			$directory = $this->thumbnailPath;
			if ( File::isDirectory($directory) ) {
				$filesArray = [];

				foreach (File::files($directory) as $key => $value) {
					$filesArray[] = asset($value);
				}

				return Response::json(['success' => $filesArray, 'thumbnailPath' => asset($this->thumbnailPath)]);
			} 

			else {
				return Response::json(['error' => 'No directory in the given path.']);
			}					
		} catch (Exception $e) {
			return Response::json(['error' => 'Server problem. Please locate a James@acw.uk.com and dispatch him to the location.']);			
		}		
	}

	public function change_settings()
	{
		try {
			if ( File::isDirectory(Input::get('imagePath')) && File::isDirectory(Input::get('thumbnailPath')) ) {
				Setting::setImagePath(Input::get('imagePath'));
				Setting::setThumbnailPath(Input::get('thumbnailPath'));

				return Response::json(['success' => 'Image paths successfully set']);
			} 

			else {
				return Response::json(['error' => 'One or both of the given directories do not exist.']);
			}					
		} catch (Exception $e) {
			return Response::json(['error' => 'Server problem. Please locate a James@acw.uk.com and dispatch him to the location.']);			
		}		
	}

}
