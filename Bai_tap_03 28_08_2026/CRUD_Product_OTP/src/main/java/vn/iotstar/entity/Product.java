package vn.iotstar.entity;
import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="products")
@NamedQuery(name="Product.findAll", query="SELECT p FROM Product p")
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int productId;

    @Column(columnDefinition ="NVARCHAR(255) NOT NULL")
    private String productName;

    private int price;
    private int quantity;

    @Column(columnDefinition ="NVARCHAR(255) NULL")
    private String images;

    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date createDate = new java.util.Date();

    @ManyToOne
    @JoinColumn(name="categoryId")
    private Category category;

    public Product() {}

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    public java.util.Date getCreateDate() { return createDate; }
    public void setCreateDate(java.util.Date createDate) { this.createDate = createDate; }
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}
