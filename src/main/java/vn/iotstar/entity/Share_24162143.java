package vn.iotstar.entity;
import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Shares")
public class Share_24162143 implements Serializable {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer shareId;
    private String emails;
    @Temporal(TemporalType.DATE)
    private Date sharedDate;
    @ManyToOne @JoinColumn(name = "Username")
    private User_24162143 user;
    @ManyToOne @JoinColumn(name = "VideoId")
    private Video_24162143 video;

    public Integer getShareId() { return shareId; }
    public void setShareId(Integer shareId) { this.shareId = shareId; }
    public String getEmails() { return emails; }
    public void setEmails(String emails) { this.emails = emails; }
    public Date getSharedDate() { return sharedDate; }
    public void setSharedDate(Date sharedDate) { this.sharedDate = sharedDate; }
    public User_24162143 getUser() { return user; }
    public void setUser(User_24162143 user) { this.user = user; }
    public Video_24162143 getVideo() { return video; }
    public void setVideo(Video_24162143 video) { this.video = video; }
}