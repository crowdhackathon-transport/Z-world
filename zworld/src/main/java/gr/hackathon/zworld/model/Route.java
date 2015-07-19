/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gr.hackathon.zworld.model;

import com.vividsolutions.jts.geom.LineString;
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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import org.hibernate.annotations.Type;

/**
 *
 * @author Acer
 */
@Entity
@Table(name = "route")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Route.findAll", query = "SELECT r FROM Route r"),
    @NamedQuery(name = "Route.findByUserId", query = "SELECT r FROM Route r WHERE r.userId = :user"),
    @NamedQuery(name = "Route.findByRouteId", query = "SELECT r FROM Route r WHERE r.routeId = :routeId")})
public class Route implements Serializable {
    @Basic(optional = false)
    @Lob
    @Column(name = "stops")
    @Type(type = "org.hibernate.spatial.GeometryType")
    private LineString stops;
    @Basic(optional = false)
    @Size(min = 1, max = 120)
    @Column(name = "tmstmp")
    private String tmstmp;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "route_id")
    private Integer routeId;
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    @ManyToOne(optional = false)
    private User userId;
    @JoinColumn(name = "end_region_id", referencedColumnName = "region_id")
    @ManyToOne(optional = false)
    private Region endRegionId;
    @JoinColumn(name = "start_region_id", referencedColumnName = "region_id")
    @ManyToOne(optional = false)
    private Region startRegionId;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "routeId")
    private List<RouteVotes> routeVotesList;

    public Route() {
    }

    public Route(Integer routeId) {
        this.routeId = routeId;
    }

    public Route(Integer routeId, LineString stops) {
        this.routeId = routeId;
        this.stops = stops;
    }

    public Route(LineString stops) {
        this.stops = stops;
    }

    public Integer getRouteId() {
        return routeId;
    }

    public void setRouteId(Integer routeId) {
        this.routeId = routeId;
    }


    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public Region getEndRegionId() {
        return endRegionId;
    }

    public void setEndRegionId(Region endRegionId) {
        this.endRegionId = endRegionId;
    }

    public Region getStartRegionId() {
        return startRegionId;
    }

    public void setStartRegionId(Region startRegionId) {
        this.startRegionId = startRegionId;
    }

    @XmlTransient
    public List<RouteVotes> getRouteVotesList() {
        return routeVotesList;
    }

    public void setRouteVotesList(List<RouteVotes> routeVotesList) {
        this.routeVotesList = routeVotesList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (routeId != null ? routeId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Route)) {
            return false;
        }
        Route other = (Route) object;
        if ((this.routeId == null && other.routeId != null) || (this.routeId != null && !this.routeId.equals(other.routeId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "gr.hackathon.zworld.model.Route[ routeId=" + routeId + " ]"+stops +userId;
    }

    public LineString getStops() {
        return stops;
    }

    public void setStops(LineString stops) {
        this.stops = stops;
    }

    public String getTmstmp() {
        return tmstmp;
    }

    public void setTmstmp(String tmstmp) {
        this.tmstmp = tmstmp;
    }
}
