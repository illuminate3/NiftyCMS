<?php
use Carbon\Carbon;

class UserController extends BaseController {

	public function __construct()
	{
		$this->user = Sentry::getUser();
		$this->isAdmin = User::isAdmin( $this->user );
		$this->logged_in_for = $this->user->last_login->diffForHumans();
		$this->configs = Setting::getSiteSettings();
		$this->paginate = 10;
		$this->cacheMinutes = 30;
		$this->rules = User::$rules;
		$this->editRules = User::$editRules;
		$this->newUserRules = User::$newUserRules;
		$this->activeParent = 'users';					
	}

	public function index()
	{
		$users = User::getUsersWithContent( $except = $this->user->id, $this->paginate );
		$usersHtml = Jamesy\BackendUsers::getUsersHtml($users);
        return View::make('backend.users.index', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,     			
        			'activeParent' => $this->activeParent,
        			'active' => 'allusers',
        			'usersHtml' => $usersHtml,
        			'links' => $users->links('backend.pagination.nifty')
        		]);
		
	}

	public function create()
	{
		$groups = Sentry::findAllGroups();

        return View::make('backend.users.new', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,     			
        			'activeParent' => $this->activeParent,
        			'active' => 'createuser',
        			'groups' => $groups
        		]);
	}

	public function store()
	{
		$validation = Jamesy\MyValidations::validate( Input::all(), $this->newUserRules );

		if($validation != NULL)
			return Redirect::back()->withErrors($validation)->withInput();

		else {
			$firstName = Jamesy\Sanitiser::trimInput( Input::get('first_name') );
			$lastName = Jamesy\Sanitiser::trimInput( Input::get('last_name') );
			$email = Jamesy\Sanitiser::trimInput( Input::get('email') );

		    $newUser = Sentry::register([
								        'email'    => $email,
								        'password' => Input::get('password_confirmation'),
								        'first_name' => $firstName,
								        'last_name' => $lastName
								    ], true);

		    $group = Sentry::findGroupById( Input::get('role') );
		    $newUser->addGroup($group);

			return Redirect::to('dashboard/users')->withSuccess('New user created.');
		}
	}

	public function edit($id)
	{
		$thisUser = Sentry::findUserById( $id );
		$userGroup = $thisUser->getGroups()[0]; 

        return View::make('backend.users.edit', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,     			
        			'activeParent' => $this->activeParent,
        			'active' => 'profile',
        			'thisUser' => $thisUser,
        			'userGroup' => $userGroup,
        			'allGroups' => Sentry::findAllGroups(),
        		]);
	}

	public function update()
	{
		$theUser = Sentry::findUserById( Input::get('id') );
		$firstName = Jamesy\Sanitiser::trimInput( Input::get('first_name') );
		$lastName = Jamesy\Sanitiser::trimInput( Input::get('last_name') );
		$email = Jamesy\Sanitiser::trimInput( Input::get('email') );

		if ( $email == $theUser->email )
			$validation = Jamesy\MyValidations::validate( Input::all(), $this->editRules );
		else
			$validation = Jamesy\MyValidations::validate( Input::all(), $this->rules );

		if($validation != NULL) {
			return Redirect::back()->withErrors($validation)->withInput();
		}

		else {
			if ( $email != $theUser->email || $firstName != $theUser->first_name || $lastName != $theUser->last_name ) {
				$theUser->first_name = $firstName;
				$theUser->last_name = $lastName;
				$theUser->email = $email;
				$theUser->save();
			}

			$currentGroup = Sentry::findGroupById( Input::get('currentGroup') );
			$group = Sentry::findGroupById( Input::get('group') );

			if ( $theUser->removeGroup( $currentGroup ) ) {
				$theUser->addGroup($group);	
			}	
		    
			return Redirect::back()->withSuccess('User updated.');
		}	
	}

	public function ban($id)
	{
		$user = Sentry::findThrottlerByUserId($id);
		
		$user->ban();

		return Redirect::back()->withSuccess('User banned');
	}

	public function un_ban($id)
	{
		$user = Sentry::findThrottlerByUserId($id);
		
		$user->unBan();

		return Redirect::back()->withSuccess('User un-banned');
	}

	public function destroy($id)
	{
		$user = Sentry::findUserById( $id );
		$user->delete();

		return Redirect::back()->withSuccess('User deleted.');
	}

	public function bulk_destroy()
	{
		$users = Input::get('users');
		$deleted = 0;

		foreach ( $users as $id ) {
			$user = Sentry::findUserById( $id  );
			if ( $user->id != Sentry::getUser()->id ) {
    			$user->delete();
    			$deleted++;
			}
    	}

    	return Redirect::back()->withSuccess( $deleted . ' ' . str_plural('user', $deleted) . ' destroyed.' );

	}


	public function profile()
	{
        return View::make('backend.users.profile', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,     			
        			'activeParent' => $this->activeParent,
        			'active' => 'profile',
        			'roles' => $this->user->getGroups(),
        			'userSince' => $this->user->created_at->diffForHumans(),
        			'userCreatedAt' => $this->user->created_at->format('D jS \\of M, Y H:i'),
        			'loggedInAt' => $this->user->last_login->format('D jS \\of M, Y H:i')
        		]);
	}

	public function update_profile()
	{
		$theUser = User::find( Input::get('id') );
		$firstName = Jamesy\Sanitiser::trimInput( Input::get('first_name') );
		$lastName = Jamesy\Sanitiser::trimInput( Input::get('last_name') );
		$email = Jamesy\Sanitiser::trimInput( Input::get('email') );

		if ( $email == $theUser->email )
			$validation = Jamesy\MyValidations::validate( Input::all(), $this->editRules );
		else
			$validation = Jamesy\MyValidations::validate( Input::all(), $this->rules );

		if($validation != NULL) {
			return Redirect::back()->withErrors($validation)->withInput();
		}

		else {
			if ( $email != $theUser->email || $firstName != $theUser->first_name || $lastName != $theUser->last_name ) {
				$theUser->first_name = $firstName;
				$theUser->last_name = $lastName;
				$theUser->email = $email;
				$theUser->save();
			}

			return Redirect::back()->withSuccess('Profile updated.');
		}		
	}

	public function password()
	{
        return View::make('backend.users.password', [
        			'user' => $this->user, 
        			'isAdmin' => $this->isAdmin, 
        			'configs' => $this->configs, 
        			'logged_in_for' => $this->logged_in_for,     			
        			'activeParent' => $this->activeParent,
        			'active' => 'profile'
        		]);
	}

	public function update_password()
	{
		$theUser = User::find( Input::get('id') );

		if ( ! Hash::check( Input::get('existing_password'), $this->user->password ) ) 
			return Redirect::back()->withExistingPassError('Wrong password.');
		
		$validation = Jamesy\MyValidations::validate( Input::all(), User::$passwordRules );

		if($validation != NULL)
			return Redirect::back()->withErrors($validation);

		else {
			$theUser->password = Hash::make( Input::get('new_password') );
			$theUser->save();

			return Redirect::back()->withSuccess('Password updated.');
		}		
	}

	public function do_edit()
	{
		$inputs = [];
		foreach(Input::all() as $key=>$input)
		{
			if($key == 'password' || $key == 'password_confirmation')
				$inputs[$key] = $input;
			else
				$inputs[$key] = Sanitiser::trimInput($input);
		}	

		if(	Sentry::getUser()->email == $inputs['email'] )
			$validation = MyValidations::validate($inputs, User::$editrules);
		else
			$validation = MyValidations::validate($inputs, User::$rules);

		if($validation != NULL)
			return Redirect::back()->withErrors($validation)->withInput();

		else
		{
			$user = User::find( Sentry::getUser()->id );
			$user->first_name = $inputs['first_name'];
			$user->last_name = $inputs['last_name'];
			$user->email = $inputs['email'];
			$user->password = Hash::make($inputs['password_confirmation']);
			$user->save();

			return Redirect::to('dashboard/profile')->with(['success' => 'Your information has been successfully updated']);

		}	
	}



}
