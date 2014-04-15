<?php

use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration {

	public function up()
	{
		Schema::create('users', function($table)
		{
			$table->increments('id');
			$table->string('email');
			$table->string('password');
			$table->text('permissions')->nullable();
			$table->boolean('activated')->default(0);
			$table->string('activation_code')->nullable();
			$table->timestamp('activated_at')->nullable();
			$table->timestamp('last_login')->nullable();
			$table->string('persist_code')->nullable();
			$table->string('reset_password_code')->nullable();
			$table->string('first_name', 128);
			$table->string('last_name', 128);
			$table->timestamps();

			$table->engine = 'InnoDB';
			$table->unique('email');
			$table->index('activation_code');
			$table->index('reset_password_code');
		});

		$date_now = date('Y-m-d H:i:s');

		$data = [
				    [
				        'email'    => 'demo@niftycms.com',
				        'password' => Hash::make('password'),
				        'activated' => 1,
				        'activated_at' => $date_now,
				        'first_name' => 'Demo',
				        'last_name' => 'NiftyCMS',
				        'created_at' => $date_now,
				        'updated_at' => $date_now
	    			]    
				];

		DB::table('users')->insert($data);			
	}


	public function down()
	{
		Schema::drop('users');
	}
}