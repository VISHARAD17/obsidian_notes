#### **INNER Join** 
```sql
select * from eaf.t_case t1 inner join eaf.t_entity_master t2 on t1.id = t2.id_case;
```
#### **Outer Join**
```sql
select * from eaf.t_case t1 outer join eaf.t_entity_master t2 on t1.id = t2.id_case;
```
