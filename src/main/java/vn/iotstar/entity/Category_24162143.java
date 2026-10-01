package vn.iotstar.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "Category")
public class Category_24162143 implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryId")
    private Integer categoryId;

    @Column(name = "Categoryname", columnDefinition = "nvarchar(100)")
    private String categoryname;

    @Column(name = "Categorycode", columnDefinition = "nvarchar(100)")
    private String categorycode;

    @Column(name = "Images", columnDefinition = "nvarchar(500)")
    private String images;

    @Column(name = "Status")
    private Boolean status;

    @OneToMany(mappedBy = "category")
    private List<Video_24162143> videos;

    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }
    public String getCategoryname() { return categoryname; }
    public void setCategoryname(String categoryname) { this.categoryname = categoryname; }
    public String getCategorycode() { return categorycode; }
    public void setCategorycode(String categorycode) { this.categorycode = categorycode; }
    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    public Boolean getStatus() { return status; }
    public void setStatus(Boolean status) { this.status = status; }
    public List<Video_24162143> getVideos() { return videos; }
    public void setVideos(List<Video_24162143> videos) { this.videos = videos; }
}