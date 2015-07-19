package gr.hackathon.zworld.model;

import gr.hackathon.zworld.model.Comments;
import gr.hackathon.zworld.model.CommentsVotes;
import gr.hackathon.zworld.model.Route;
import gr.hackathon.zworld.model.RouteVotes;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-07-19T15:58:12")
@StaticMetamodel(User.class)
public class User_ { 

    public static volatile SingularAttribute<User, String> fbId;
    public static volatile ListAttribute<User, Route> routeList;
    public static volatile ListAttribute<User, CommentsVotes> commentsVotesList;
    public static volatile ListAttribute<User, RouteVotes> routeVotesList;
    public static volatile SingularAttribute<User, String> username;
    public static volatile SingularAttribute<User, String> email;
    public static volatile SingularAttribute<User, Integer> userId;
    public static volatile SingularAttribute<User, String> name;
    public static volatile SingularAttribute<User, String> surname;
    public static volatile ListAttribute<User, Comments> commentsList;
    public static volatile SingularAttribute<User, String> password;

}