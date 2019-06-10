package com.tj4752.data_discuss.api;

import com.tj4752.data_discuss.models.Blog;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Query;

public interface ApiInterface {

    @GET("posts")
    Call<Blog> getBlogs(
            @Query("key") String key
    );
}
