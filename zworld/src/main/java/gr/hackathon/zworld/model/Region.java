/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gr.hackathon.zworld.model;

import com.vividsolutions.jts.geom.Point;
import com.vividsolutions.jts.geom.Polygon;
import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
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
@Table(name = "region")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Region.findAll", query = "SELECT r FROM Region r"),
    @NamedQuery(name = "Region.findByRegionId", query = "SELECT r FROM Region r WHERE r.regionId = :regionId"),
    @NamedQuery(name = "Region.findByName", query = "SELECT r FROM Region r WHERE r.name = :name")})
public class Region implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Lob
    @Type(type = "org.hibernate.spatial.GeometryType")
    @Column(name = "bounds")
    private Polygon bounds;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Type(type = "org.hibernate.spatial.GeometryType")
    @Column(name = "center")
    private Point center;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "region_id")
    private Integer regionId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 120)
    @Column(name = "name")
    private String name;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "endRegionId")
    private List<Route> routeList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "startRegionId")
    private List<Route> routeList1;

    public Region() {
    }

    public Region(Integer regionId) {
        this.regionId = regionId;
    }

    public Region(Integer regionId, String name, Polygon bounds, Point center) {
        this.regionId = regionId;
        this.name = name;
        this.bounds = bounds;
        this.center = center;
    }

    public Region(String name, Polygon bounds, Point center) {
        this.name = name;
        this.bounds = bounds;
        this.center = center;
    }

    public Integer getRegionId() {
        return regionId;
    }

    public void setRegionId(Integer regionId) {
        this.regionId = regionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    @XmlTransient
    public List<Route> getRouteList() {
        return routeList;
    }

    public void setRouteList(List<Route> routeList) {
        this.routeList = routeList;
    }

    @XmlTransient
    public List<Route> getRouteList1() {
        return routeList1;
    }

    public void setRouteList1(List<Route> routeList1) {
        this.routeList1 = routeList1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (regionId != null ? regionId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Region)) {
            return false;
        }
        Region other = (Region) object;
        if ((this.regionId == null && other.regionId != null) || (this.regionId != null && !this.regionId.equals(other.regionId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "gr.hackathon.zworld.model.Region[ regionId=" + regionId + " ]";
    }

    public Polygon getBounds() {
        return bounds;
    }

    public void setBounds(Polygon bounds) {
        this.bounds = bounds;
    }

    public Point getCenter() {
        return center;
    }

    public void setCenter(Point center) {
        this.center = center;
    }
}
