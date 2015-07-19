package gr.hackathon.zworld.model;

import gr.hackathon.zworld.model.Route;
import gr.hackathon.zworld.model.User;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-07-19T15:58:12")
@StaticMetamodel(RouteVotes.class)
public class RouteVotes_ { 

    public static volatile SingularAttribute<RouteVotes, Integer> voteStatus;
    public static volatile SingularAttribute<RouteVotes, Integer> routeVotesId;
    public static volatile SingularAttribute<RouteVotes, User> userId;
    public static volatile SingularAttribute<RouteVotes, Route> routeId;

}