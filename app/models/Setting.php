<?php

class Setting extends Eloquent {
	
	public static $rules = [
								'sitename' => 'required|max:255'
						   ];

  	public static function getSiteSettings()
  	{
  		return static::first();
  	}

	public static function getThumbnailPath()
	{
        $thumbnailPath = Cache::rememberForever('thumbnailPath', function()
        {
            return "files/_thumbs/images";
        }); 

        return $thumbnailPath;
	}

	public static function setThumbnailPath($path)
	{
		Cache::forget('thumbnailPath');
		Cache::forever('thumbnailPath', $path);

		return true;
	}

	public static function getImagePath()
	{
        $imagePath = Cache::rememberForever('imagePath', function()
        {
            return "files/images";
        }); 

        return $imagePath;
	}

	public static function setImagePath($path)
	{
		Cache::forget('imagePath');
		Cache::forever('imagePath', $path);

		return true;
	}	

}
