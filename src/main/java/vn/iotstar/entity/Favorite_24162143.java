package vn.iotstar.entity;
import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Favorites")
public class Favorite_24162143 implements Serializable {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer favoriteId;
    @Temporal(TemporalType.DATE)
    private Date likedDate;
    @ManyToOne @JoinColumn(name = "VideoId")
    private Video_24162143 video;
    @ManyToOne @JoinColumn(name = "Username")
    private User_24162143 user;

    public Integer getFavoriteId() { return favoriteId; }
    public void setFavoriteId(Integer favoriteId) { this.favoriteId = favoriteId; }
    public Date getLikedDate() { return likedDate; }
    public void setLikedDate(Date likedDate) { this.likedDate = likedDate; }
    public Video_24162143 getVideo() { return video; }
    public void setVideo(Video_24162143 video) { this.video = video; }
    public User_24162143 getUser() { return user; }
    public void setUser(User_24162143 user) { this.user = user; }
}