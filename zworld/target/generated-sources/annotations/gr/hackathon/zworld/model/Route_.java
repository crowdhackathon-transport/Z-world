package gr.hackathon.zworld.model;

import com.vividsolutions.jts.geom.LineString;
import gr.hackathon.zworld.model.Region;
import gr.hackathon.zworld.model.RouteVotes;
import gr.hackathon.zworld.model.User;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-07-19T15:58:12")
@StaticMetamodel(Route.class)
public class Route_ { 

    public static volatile SingularAttribute<Route, LineString> stops;
    public static volatile ListAttribute<Route, RouteVotes> routeVotesList;
    public static volatile SingularAttribute<Route, Region> startRegionId;
    public static volatile SingularAttribute<Route, User> userId;
    public static volatile SingularAttribute<Route, Region> endRegionId;
    public static volatile SingularAttribute<Route, Integer> routeId;
    public static volatile SingularAttribute<Route, String> tmstmp;

}