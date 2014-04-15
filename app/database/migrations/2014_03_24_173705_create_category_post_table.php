<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateCategoryPostTable extends Migration {

	public function up()
	{
		Schema::create('category_post', function(Blueprint $table) {
			$table->increments('id');
			$table->integer('category_id')->unsigned()->index();
			$table->integer('post_id')->unsigned()->index();

			$table->foreign('category_id')->references('id')->on('categories')->onDelete('cascade');
			$table->foreign('post_id')->references('id')->on('posts')->onDelete('cascade');
			
		});
	}


	public function down()
	{
		Schema::drop('category_post');
	}

}
