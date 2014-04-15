<?php

Route::group(['before' => 'redirectIfLoggedIn'], function()
{
	Route::get('dashboard/login', 'AuthenticationController@login');
	Route::get('dashboard/{hashid}/reset-pass-from-email', 'AuthenticationController@generate_new_pass');
});

Route::group(['before' => 'csrf'], function()
{
	Route::post('dashboard/login', 'AuthenticationController@do_login');
	Route::post('dashboard/request-pass', 'AuthenticationController@send_new_pass');
});

Route::group(['before' => 'checkLoggedIn'], function() {

	Route::get('dashboard', 'DashboardController@index');
	Route::get('dashboard/profile', 'DashboardController@profile');
	Route::get('dashboard/select-featured-image', 'DashboardController@select_featured_image');

	/*****************PAGES*******************/
	Route::get('dashboard/pages', 'PageController@index');
	Route::get('dashboard/pages/{hash}/preview', 'FrontendController@previewPage');
	Route::get('dashboard/pages/published', 'PageController@published_pages');
	Route::get('dashboard/pages/drafts', 'PageController@draft_pages');
	Route::get('dashboard/pages/trash', 'PageController@deleted_pages');
	Route::get('dashboard/pages/create', 'PageController@create');
	Route::get('dashboard/pages/{id}/edit', 'PageController@edit');
	Route::get('dashboard/pages/{id}/delete', 'PageController@delete');
	Route::get('dashboard/pages/{id}/restore', 'PageController@restore');
	Route::get('dashboard/pages/{id}/destroy', 'PageController@destroy');
	Route::get('dashboard/pages/{id}/versions', 'PageController@versions');

	/*****************BLOG POSTS*******************/
	Route::get('dashboard/blog', 'PostController@index');
	Route::get('dashboard/blog/posts', 'PostController@index');
	Route::get('dashboard/blog/posts/create', 'PostController@create');
	Route::get('dashboard/blog/posts/{id}/edit', 'PostController@edit');
	Route::get('dashboard/blog/posts/{id}/delete', 'PostController@delete');
	Route::get('dashboard/blog/posts/{id}/restore', 'PostController@restore');
	Route::get('dashboard/blog/posts/{id}/destroy', 'PostController@destroy');		
	Route::get('dashboard/blog/posts/published', 'PostController@published_posts');
	Route::get('dashboard/blog/posts/drafts', 'PostController@draft_posts');
	Route::get('dashboard/blog/posts/trash', 'PostController@deleted_posts');
	Route::get('dashboard/blog/posts/{hash}/preview', 'FrontendController@previewPost');

	/*****************BLOG CATEGORIES*******************/
	Route::get('dashboard/blog/categories', 'CategoryController@index');
	Route::get('dashboard/blog/categories/create', 'CategoryController@create');
	Route::get('dashboard/blog/categories/{id}/edit', 'CategoryController@edit');
	Route::get('dashboard/blog/categories/{id}/destroy', 'CategoryController@destroy');

	/*****************USERS******************************/
	Route::get('dashboard/users/profile', 'UserController@profile');
	Route::get('dashboard/users/profile/password', 'UserController@password');
	Route::group(['before' => 'checkIsAdmin'], function() {
		Route::get('dashboard/users', 'UserController@index');
		Route::get('dashboard/users/create', 'UserController@create');
		Route::get('dashboard/users/{id}/edit', 'UserController@edit');
		Route::get('dashboard/users/{id}/ban', 'UserController@ban');
		Route::get('dashboard/users/{id}/unban', 'UserController@un_ban');
		Route::get('dashboard/users/{id}/destroy', 'UserController@destroy');
		
		Route::group(['before' => 'csrf'], function()
		{
			Route::post('dashboard/users/store', 'UserController@store');
			Route::post('dashboard/users/update', 'UserController@update');
			Route::post('dashboard/users/bulk-destroy', 'UserController@bulk_destroy');
		});			
	});

	Route::group(['before' => 'csrf'], function()
	{
		/*****************DASHBOARD*******************/
		Route::post('dashboard/change-settings', 'DashboardController@change_settings');

		/*****************PAGES*******************/
		Route::post('dashboard/pages/create', 'PageController@store');
		Route::post('dashboard/pages/{id}/update', 'PageController@update');
		Route::post('dashboard/pages/bulk-publish', 'PageController@bulk_publish');
		Route::post('dashboard/pages/bulk-draft', 'PageController@bulk_draft');
		Route::post('dashboard/pages/bulk-delete', 'PageController@bulk_delete');
		Route::post('dashboard/pages/bulk-restore', 'PageController@bulk_restore');
		Route::post('dashboard/pages/bulk-destroy', 'PageController@bulk_destroy');
		Route::post('dashboard/pages/{id}/select-version', 'PageController@select_version');

		/*****************BLOG POSTS*******************/
		Route::post('dashboard/blog/posts/create', 'PostController@store');
		Route::post('dashboard/blog/posts/{id}/update', 'PostController@update');
		Route::post('dashboard/blog/posts/bulk-publish', 'PostController@bulk_publish');
		Route::post('dashboard/blog/posts/bulk-draft', 'PostController@bulk_draft');
		Route::post('dashboard/blog/posts/bulk-delete', 'PostController@bulk_delete');
		Route::post('dashboard/blog/posts/bulk-restore', 'PostController@bulk_restore');
		Route::post('dashboard/blog/posts/bulk-destroy', 'PostController@bulk_destroy');

		/*****************BLOG CATEGORIES*******************/
		Route::post('dashboard/blog/categories/create', 'CategoryController@store');
		Route::post('dashboard/blog/categories/{id}/update', 'CategoryController@update');
		Route::post('dashboard/blog/categories/bulk-destroy', 'CategoryController@bulk_destroy');			

		/*****************USERS*******************/
		Route::post('dashboard/users/profile', 'UserController@update_profile');	
		Route::post('dashboard/users/profile/password', 'UserController@update_password');	
	});
	
});

Route::get('dashboard/logout', 'AuthenticationController@logout');

Route::get('/', 'FrontendController@index');	
Route::get('{any}/contact-us', 'FrontendController@contact_us');
Route::get('contact-us', 'FrontendController@contact_us');

Route::group(['before' => 'csrf'], function()
{
	Route::post('contact-us', 'FrontendController@do_contact_us');
});

Route::get('search', ['as' => 'search', 'uses' => 'FrontendController@do_search']);

Route::get('test', function() {

});

Route::get('blog', 'FrontendController@get_blog');
Route::get('blog/{any}', 'FrontendController@get_post')->where('any', '.*');
Route::get('{page}', 'FrontendController@get_page')->where('page', '.*');


