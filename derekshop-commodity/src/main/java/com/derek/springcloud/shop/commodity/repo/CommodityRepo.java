//package com.derek.springcloud.shop.commodity.repo;
//
//import com.derek.springcloud.shop.commodity.entities.Commodity;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.data.rest.core.annotation.RepositoryRestResource;
//import org.springframework.data.rest.core.annotation.RestResource;
//
//import java.util.UUID;
//
//
//@RepositoryRestResource
//public interface CommodityRepo extends JpaRepository<Commodity, UUID> {
//
//    // Prevents GET /books/:id
//    @Override
//    Commodity getOne(UUID id);
//
//    // Prevents GET /books
//    @Override
//    Page<Commodity> findAll(Pageable pageable);
//
//    // Prevents POST /books and PATCH /books/:id
//    @Override
//    Commodity save(Commodity s);
//
//    // Prevents DELETE /books/:id
//    @Override
//    @RestResource(exported = false)
//    void delete(Commodity t);
//}
