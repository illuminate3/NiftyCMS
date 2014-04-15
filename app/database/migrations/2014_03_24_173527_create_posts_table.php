<?php

use Illuminate\Database\Migrations\Migration;

class CreatePostsTable extends Migration {

	public function up()
	{
	    Schema::create('posts', function($table) 
	    {
	      	$table->increments('id');
	      	$table->integer('user_id')->unsigned();
	      	$table->string('title', 255);
	      	$table->string('slug', 255);
			$table->string('summary',512);
			$table->text('content');
			$table->text('featured_image', 255)->nullable();
			$table->text('link', 255)->nullable();
			$table->integer('order');
			$table->boolean('is_online')->default(0);
			$table->boolean('is_deleted')->default(0);
	      	$table->timestamps();

	      	$table->index('slug');
	      	$table->engine = "InnoDB";
	      	$table->foreign('user_id')->references('id')->on('users');
	    });
	}

	public function down()
	{
		Schema::drop('posts');
	}

}