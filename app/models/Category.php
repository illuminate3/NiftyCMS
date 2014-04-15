<?php

class Category extends Eloquent {
	protected $guarded = array();

	public static $rules = ['name' => 'required|max:255|unique:categories'];

	public function posts()
	{
		return $this->belongsToMany('Post');
	}

	public static function getCategoryList()
	{
		return static::whereNotIn('id', [1])->lists('name', 'id');
	}

	public static function getCategories($paginate)
	{
		return static::with('posts')->whereNotIn('id', [1])->paginate($paginate);
	}

}
