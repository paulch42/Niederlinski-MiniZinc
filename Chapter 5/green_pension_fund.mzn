% PROBLEM STATEMENT IS UNCLEAR

enum appliance = {appliance_a, appliance_b};
enum tet = {tet_small, tet_large};

int: daily_tet_max = 120;
array[appliance] of int: max_convertion = [60,50];
array[appliance] of int: conversion_profit = [300,500];

array[appliance] of var 0..sum(max_convertion): num_converted;
array[tet] of var 0..daily_tet_max: num_produced;

constraint forall(a in appliance)(num_converted[a] <= max_convertion[a]);
constraint sum(num_converted) <= daily_tet_max;
constraint num_produced[tet_small] = sum(num_converted);
constraint num_produced[tet_large] = num_converted[appliance_b];

solve maximize(sum(a in appliance)(num_converted[a] * conversion_profit[a]));