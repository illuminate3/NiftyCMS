<?php

use Illuminate\Database\Migrations\Migration;

class CreateGroupsTable extends Migration {

	public function up()
	{
		Schema::create('groups', function($table)
		{
			$table->increments('id');
			$table->string('name');
			$table->text('permissions')->nullable();
			$table->timestamps();

			$table->engine = 'InnoDB';
			$table->unique('name');
		});

		$date_now = date('Y-m-d H:i:s');

		$data = [
				    [
				        'name'    => 'Administrator',
				        'created_at' => $date_now,
				        'updated_at' => $date_now
	    			],
				    [
				        'name'    => 'Publisher',
				        'created_at' => $date_now,
				        'updated_at' => $date_now
	    			]     
				];

		DB::table('groups')->insert($data);		
	}

	public function down()
	{
		Schema::drop('groups');
	}

}