package com.derek.springcloud.shop.commodity.entities;

import lombok.Data;
import org.hibernate.annotations.Type;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.sql.Timestamp;
import java.util.UUID;

@Entity
@Data
public class Commodity {
	@Id 
	@GeneratedValue
	@Type(type = "uuid-char")
	@Column(name = "CO_NO")
	private UUID coNo;
	@Column(name = "CO_NAME", nullable = false)
	private String coName;
	@Column(name = "CO_DESC", nullable = false)
	private String coDesc;
	@Column(name = "CO_IMG_URL", nullable = false)
	private String coImgUrl;
	@Column(name = "CO_PRICE", nullable = false)
	private Double coPrice;
	@Column(name = "CO_PAY_TYPE", nullable = false)
	private Character coPayType;
	@Column(name = "CREATED_USER", nullable = false)
	private String createdUser;
	@Column(name = "CREATED_TIME", nullable = false)
	private Timestamp createdTime;
}
