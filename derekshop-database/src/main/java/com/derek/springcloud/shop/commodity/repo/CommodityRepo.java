package com.derek.springcloud.shop.commodity.repo;

import com.derek.springcloud.shop.commodity.entities.Commodity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface CommodityRepo extends JpaRepository<Commodity, UUID> {

}
