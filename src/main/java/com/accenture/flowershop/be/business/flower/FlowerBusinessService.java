package com.accenture.flowershop.be.business.flower;

import com.accenture.flowershop.be.entity.flower.Flower;

import java.util.Collection;
import java.util.List;

public interface FlowerBusinessService {
    List getAllFlowers();

    Flower order(Flower flower, int amount);

    Flower returnToStock(Flower flower, int amount);

    Collection<Flower> getFlowers(Collection<Long> flowerIds);
}
