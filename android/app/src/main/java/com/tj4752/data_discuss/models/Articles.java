package com.tj4752.data_discuss.models;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

class Articles {

    @SerializedName("id")
    @Expose
    private String id;

    @SerializedName("title")
    @Expose
    private String title;

    @SerializedName("excerpt")
    @Expose
    private String excerpt;

    @SerializedName("html")
    @Expose
    private String content;

    @SerializedName("feature_image")
    @Expose
    private String Thumbnail;

    @SerializedName("published_at")
    @Expose
    private String publishedTime;
}
