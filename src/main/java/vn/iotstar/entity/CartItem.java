package vn.iotstar.entity;

import java.io.Serializable;

public class CartItem implements Serializable {
    private Video_24162143 video;
    private int quantity;
    private double price;

    public CartItem(Video_24162143 video, int quantity, double price) {
        this.video = video;
        this.quantity = quantity;
        this.price = price;
    }

    public Video_24162143 getVideo() { return video; }
    public void setVideo(Video_24162143 video) { this.video = video; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public double getTotalPrice() { return this.price * this.quantity; }
}