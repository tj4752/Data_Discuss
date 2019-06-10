package com.tj4752.data_discuss.models;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class Blog {

    @SerializedName("posts")
    @Expose
    private List<Articles> blog;

    public List<Articles> getBlog() {
        return blog;
    }

    public void setBlog(List<Articles> blog) {
        this.blog = blog;
    }
}
