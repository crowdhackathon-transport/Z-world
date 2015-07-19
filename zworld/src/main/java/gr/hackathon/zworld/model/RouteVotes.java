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
@Table(name = "route_votes")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RouteVotes.findAll", query = "SELECT r FROM RouteVotes r"),
    @NamedQuery(name = "RouteVotes.findByRouteVotesId", query = "SELECT r FROM RouteVotes r WHERE r.routeVotesId = :routeVotesId"),
    @NamedQuery(name = "RouteVotes.findByVoteStatus", query = "SELECT r FROM RouteVotes r WHERE r.voteStatus = :voteStatus")})
public class RouteVotes implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "route_votes_id")
    private Integer routeVotesId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "vote_status")
    private int voteStatus;
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    @ManyToOne(optional = false)
    private User userId;
    @JoinColumn(name = "route_id", referencedColumnName = "route_id")
    @ManyToOne(optional = false)
    private Route routeId;

    public RouteVotes() {
    }

//    public RouteVotes(Integer routeVotesId) {
//        this.routeVotesId = routeVotesId;
//    }
    public RouteVotes(Integer routeVotesId, int voteStatus) {
        this.routeVotesId = routeVotesId;
        this.voteStatus = voteStatus;
    }

    public RouteVotes(Integer routeVotesId, int voteStatus, User userId, Route routeId) {
        this.voteStatus = voteStatus;
        this.userId = userId;
        this.routeId = routeId;
        this.routeVotesId = routeVotesId;
    }

    public Integer getRouteVotesId() {
        return routeVotesId;
    }

    public void setRouteVotesId(Integer routeVotesId) {
        this.routeVotesId = routeVotesId;
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

    public Route getRouteId() {
        return routeId;
    }

    public void setRouteId(Route routeId) {
        this.routeId = routeId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (routeVotesId != null ? routeVotesId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RouteVotes)) {
            return false;
        }
        RouteVotes other = (RouteVotes) object;
        if ((this.routeVotesId == null && other.routeVotesId != null) || (this.routeVotesId != null && !this.routeVotesId.equals(other.routeVotesId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "gr.hackathon.zworld.model.RouteVotes[ routeVotesId=" + routeVotesId + " ]";
    }
}
