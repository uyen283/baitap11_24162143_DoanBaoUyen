package vn.iotstar.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "Videos")
public class Video_24162143 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "VideoId", length = 50)
    private String videoId;

    @Column(name = "Title", columnDefinition = "nvarchar(200)")
    private String title;

    @Column(name = "Poster", columnDefinition = "nvarchar(500)")
    private String poster;

    @Column(name = "Views")
    private Integer views;

    @Column(name = "Description", columnDefinition = "nvarchar(500)")
    private String description;

    @Column(name = "Active")
    private Boolean active;

    // Bổ sung thuộc tính Giá bán
    @Column(name = "price")
    private Double price;

    @ManyToOne
    @JoinColumn(name = "CategoryId")
    private Category_24162143 category;

    @OneToMany(mappedBy = "video")
    private List<Favorite_24162143> favorites;

    @OneToMany(mappedBy = "video")
    private List<Share_24162143> shares;

    public Video_24162143() {}

    public String getVideoId() { return videoId; }
    public void setVideoId(String videoId) { this.videoId = videoId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }
    public Integer getViews() { return views; }
    public void setViews(Integer views) { this.views = views; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Boolean getActive() { return active; }
    public void setActive(Boolean active) { this.active = active; }

    // Getter và Setter cho Price (Đặt giá mặc định 50,000đ nếu chưa nhập)
    public Double getPrice() { 
        return (price != null) ? price : 50000.0; 
    }
    public void setPrice(Double price) { this.price = price; }

    public Category_24162143 getCategory() { return category; }
    public void setCategory(Category_24162143 category) { this.category = category; }
    public List<Favorite_24162143> getFavorites() { return favorites; }
    public void setFavorites(List<Favorite_24162143> favorites) { this.favorites = favorites; }
    public List<Share_24162143> getShares() { return shares; }
    public void setShares(List<Share_24162143> shares) { this.shares = shares; }
}