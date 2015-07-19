/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gr.hackathon.zworld.model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Acer
 */
@Entity
@Table(name = "comments_votes")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CommentsVotes.findAll", query = "SELECT c FROM CommentsVotes c"),
    @NamedQuery(name = "CommentsVotes.findByCommentVoteId", query = "SELECT c FROM CommentsVotes c WHERE c.commentVoteId = :commentVoteId"),
    @NamedQuery(name = "CommentsVotes.findByVoteStatus", query = "SELECT c FROM CommentsVotes c WHERE c.voteStatus = :voteStatus")})
public class CommentsVotes implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_vote_id")
    private Integer commentVoteId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "vote_status")
    private int voteStatus;
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    @ManyToOne(optional = false)
    private User userId;
    @JoinColumn(name = "comment_id", referencedColumnName = "comment_id")
    @ManyToOne(optional = false)
    private Comments commentId;

    public CommentsVotes() {
    }

//    public CommentsVotes(Integer commentVoteId) {
//        this.commentVoteId = commentVoteId;
//    }

    public CommentsVotes(Integer commentVoteId, int voteStatus) {
        this.commentVoteId = commentVoteId;
        this.voteStatus = voteStatus;
    }

    public CommentsVotes(int voteStatus) {
        this.voteStatus = voteStatus;
    }

    public Integer getCommentVoteId() {
        return commentVoteId;
    }

    public void setCommentVoteId(Integer commentVoteId) {
        this.commentVoteId = commentVoteId;
    }

    public int getVoteStatus() {
        return voteStatus;
    }

    public void setVoteStatus(int voteStatus) {
        this.voteStatus = voteStatus;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public Comments getCommentId() {
        return commentId;
    }

    public void setCommentId(Comments commentId) {
        this.commentId = commentId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (commentVoteId != null ? commentVoteId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CommentsVotes)) {
            return false;
        }
        CommentsVotes other = (CommentsVotes) object;
        if ((this.commentVoteId == null && other.commentVoteId != null) || (this.commentVoteId != null && !this.commentVoteId.equals(other.commentVoteId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "gr.hackathon.zworld.model.CommentsVotes[ commentVoteId=" + commentVoteId + " ]";
    }
}
