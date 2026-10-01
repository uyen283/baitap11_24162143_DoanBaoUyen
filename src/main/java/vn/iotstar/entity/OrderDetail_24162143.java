package vn.iotstar.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "OrderDetails")
public class OrderDetail_24162143 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int detailId;

    private int quantity;
    private double price;

    @ManyToOne
    @JoinColumn(name = "OrderId")
    private Order_24162143 order;

    @ManyToOne
    @JoinColumn(name = "VideoId")
    private Video_24162143 video;

    public OrderDetail_24162143() {}

    // Getters và Setters
    public int getDetailId() { return detailId; }
    public void setDetailId(int detailId) { this.detailId = detailId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public Order_24162143 getOrder() { return order; }
    public void setOrder(Order_24162143 order) { this.order = order; }
    public Video_24162143 getVideo() { return video; }
    public void setVideo(Video_24162143 video) { this.video = video; }
}