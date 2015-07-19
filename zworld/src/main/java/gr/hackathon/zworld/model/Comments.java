/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gr.hackathon.zworld.model;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Acer
 */
@Entity
@Table(name = "comments")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Comments.findAll", query = "SELECT c FROM Comments c"),
    @NamedQuery(name = "Comments.findByCommentId", query = "SELECT c FROM Comments c WHERE c.commentId = :commentId"),
    @NamedQuery(name = "Comments.findByRouteId", query = "SELECT c FROM Comments c WHERE c.routeId = :routeId"),
    @NamedQuery(name = "Comments.findByDescription", query = "SELECT c FROM Comments c WHERE c.description = :description")})
public class Comments implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 120)
    @Column(name = "tmstmp")
    private String tmstmp;
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    @ManyToOne(optional = false)
    private User userId;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_id")
    private Integer commentId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "route_id")
    private int routeId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "description")
    private String description;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "commentId")
    private List<CommentsVotes> commentsVotesList;

    public Comments() {
    }

    public Comments(Integer commentId) {
        this.commentId = commentId;
    }

    public Comments(Integer commentId, int routeId, String description) {
        this.commentId = commentId;
        this.routeId = routeId;
        this.description = description;
    }

    public Comments(int routeId, String description) {
        this.routeId = routeId;
        this.description = description;
    }

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public int getRouteId() {
        return routeId;
    }

    public void setRouteId(int routeId) {
        this.routeId = routeId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @XmlTransient
    public List<CommentsVotes> getCommentsVotesList() {
        return commentsVotesList;
    }

    public void setCommentsVotesList(List<CommentsVotes> commentsVotesList) {
        this.commentsVotesList = commentsVotesList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (commentId != null ? commentId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Comments)) {
            return false;
        }
        Comments other = (Comments) object;
        if ((this.commentId == null && other.commentId != null) || (this.commentId != null && !this.commentId.equals(other.commentId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "gr.hackathon.zworld.model.Comments[ commentId=" + commentId + " ]";
    }

    public String getTmstmp() {
        return tmstmp;
    }

    public void setTmstmp(String tmstmp) {
        this.tmstmp = tmstmp;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }
}
