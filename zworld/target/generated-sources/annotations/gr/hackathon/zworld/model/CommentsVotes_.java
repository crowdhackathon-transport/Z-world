package gr.hackathon.zworld.model;

import gr.hackathon.zworld.model.Comments;
import gr.hackathon.zworld.model.User;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-07-19T15:58:12")
@StaticMetamodel(CommentsVotes.class)
public class CommentsVotes_ { 

    public static volatile SingularAttribute<CommentsVotes, Integer> voteStatus;
    public static volatile SingularAttribute<CommentsVotes, User> userId;
    public static volatile SingularAttribute<CommentsVotes, Integer> commentVoteId;
    public static volatile SingularAttribute<CommentsVotes, Comments> commentId;

}