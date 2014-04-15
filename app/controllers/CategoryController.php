<?php
use Carbon\Carbon;

class CategoryController extends BaseController {

	public function __construct()
	{
		$this->user = Sentry::getUser();
		$this->isAdmin = User::isAdmin( $this->user );
		$this->logged_in_for = $this->user->last_login->diffForHumans();
		$this->configs = Setting::getSiteSettings();
		$this->paginate = 10;
		$this->cacheMinutes = 30;
		$this->rules = Category::$rules;
		$this->activeParent = 'blog';					
	}

	public function index()
	{
		$categories = Category::getCategories( $this->paginate ); 
		$categoriesHtml = Jamesy\BackendCategories::getCategoriesHtml( $categories ); 

        return View::make('backend.categories.index', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,   
        			'categoriesHtml' => $categoriesHtml,       			
        			'activeParent' => $this->activeParent,
        			'active' => 'allcategories',
        			'links' => $categories->links('backend.pagination.nifty')
        		]);
	}


	public function create()
	{
        return View::make('backend.categories.new', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,       			
        			'activeParent' => $this->activeParent,
        			'active' => 'createcategory'
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

			$name = Jamesy\Sanitiser::trimInput( Input::get('name') );

			$category = new Category;
			$category->name = $name;
			$category->save();

			return Redirect::to('dashboard/blog/categories')->withSuccess('New category created.');
		}
	}


	public function edit($id)
	{
		$category = Category::find($id);
        return View::make('backend.categories.edit', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,       			
        			'activeParent' => $this->activeParent,
        			'active' => 'createcategory',
        			'category' => $category
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

			$name = Jamesy\Sanitiser::trimInput( Input::get('name') );

			$category = Category::find($id);
			$category->name = $name;
			$category->save();

			return Redirect::to('dashboard/blog/categories')->withSuccess('Category updated.');
		}		
	}


	public function destroy($id)
	{
		Category::whereId($id)->delete();
		Cache::flush();

		return Redirect::back()->withSuccess('Category destroyed.');
	}

	public function bulk_destroy()
	{
		$categoryIds = Input::get('categories'); 
		$deleted = 0; 

		Category::whereIn('id', $categoryIds)->delete();
		Cache::flush();

		return Redirect::back()->withSuccess(count($categoryIds) . ' ' . str_plural('category', count($categoryIds)) . ' destroyed.');
	}

}
