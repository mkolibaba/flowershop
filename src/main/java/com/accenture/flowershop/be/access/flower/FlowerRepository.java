package com.accenture.flowershop.be.access.flower;

import com.accenture.flowershop.be.entity.flower.Flower;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;

@Repository
public interface FlowerRepository extends CrudRepository<Flower, Long> {
    Collection<Flower> findFlowersByIdIn(Collection<Long> ids);
}
