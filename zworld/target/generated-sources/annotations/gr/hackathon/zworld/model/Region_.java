package gr.hackathon.zworld.model;

import com.vividsolutions.jts.geom.Point;
import com.vividsolutions.jts.geom.Polygon;
import gr.hackathon.zworld.model.Route;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-07-19T15:58:12")
@StaticMetamodel(Region.class)
public class Region_ { 

    public static volatile SingularAttribute<Region, Polygon> bounds;
    public static volatile SingularAttribute<Region, Point> center;
    public static volatile ListAttribute<Region, Route> routeList;
    public static volatile SingularAttribute<Region, String> name;
    public static volatile ListAttribute<Region, Route> routeList1;
    public static volatile SingularAttribute<Region, Integer> regionId;

}