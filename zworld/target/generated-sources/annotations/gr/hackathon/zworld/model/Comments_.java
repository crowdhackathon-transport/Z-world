package gr.hackathon.zworld.model;

import gr.hackathon.zworld.model.CommentsVotes;
import gr.hackathon.zworld.model.User;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-07-19T15:58:12")
@StaticMetamodel(Comments.class)
public class Comments_ { 

    public static volatile ListAttribute<Comments, CommentsVotes> commentsVotesList;
    public static volatile SingularAttribute<Comments, String> description;
    public static volatile SingularAttribute<Comments, User> userId;
    public static volatile SingularAttribute<Comments, Integer> routeId;
    public static volatile SingularAttribute<Comments, String> tmstmp;
    public static volatile SingularAttribute<Comments, Integer> commentId;

}