<?php

use Illuminate\Database\Migrations\Migration;

class CreateCategoriesTable extends Migration {

	public function up()
	{
	    Schema::create('categories', function($table) 
	    {
	      	$table->increments('id');
	      	$table->string('name', 255);
	      	$table->timestamps();

	      	$table->engine = "InnoDB";
	    });

		$date_now = date('Y-m-d H:i:s');

		$data = [
				    [
			        	'name'    => 'Uncategorised',
			        	'created_at' => $date_now,
			        	'updated_at' => $date_now
	    			]    
				];

		DB::table('categories')->insert($data);
	}

	public function down()
	{
		Schema::drop('categories');
	}

}