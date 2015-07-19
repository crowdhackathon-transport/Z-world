/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gr.hackathon.zworld.util;

import gr.hackathon.zworld.model.Comments;
import gr.hackathon.zworld.model.CommentsVotes;
import gr.hackathon.zworld.model.Region;
import gr.hackathon.zworld.model.Route;
import gr.hackathon.zworld.model.RouteVotes;
import gr.hackathon.zworld.model.User;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author Acer
 */
public class ZworldUtils {

    public static EntityManagerFactory factory = Persistence.createEntityManagerFactory("jpaPU");

    public static User getUserById(int userId) throws Exception {
        EntityManager em = factory.createEntityManager();
        Query query = em.createNamedQuery("User.findByUserId");
        query.setParameter("userId", userId);
        User user = (User) query.getSingleResult();
        return user;
    }

    public static Region getRegionById(int regionId) throws Exception {
        EntityManager em = factory.createEntityManager();
        Query query = em.createNamedQuery("Region.findByRegionId");
        query.setParameter("regionId", regionId);
        Region region = (Region) query.getSingleResult();
        return region;
    }

    public static Route getRouteById(int routeId) throws Exception {
        EntityManager em = factory.createEntityManager();
        Query query = em.createNamedQuery("Route.findByRouteId");
        query.setParameter("routeId", routeId);
        Route route = (Route) query.getSingleResult();
        return route;
    }

    public static List<Route> getAllRouteList() throws Exception {
        EntityManager em = factory.createEntityManager();
        Query query = em.createNamedQuery("Route.findAll");
        //query.setParameter("userId", userId);
        List<Route> routeList = new ArrayList<Route>();
        routeList = query.getResultList();
        return routeList;
    }

    public static List<Route> getAllRouteByUserId(int userId) throws Exception {
        EntityManager em = factory.createEntityManager();
        Query query = em.createNamedQuery("Route.findByUserId");
        User user = new User();
        user.setUserId(userId);
        query.setParameter("user", user);
        List<Route> routeList = new ArrayList<Route>();
        routeList = query.getResultList();
        return routeList;
    }

    public static List<Comments> getAllComments() throws Exception {
        EntityManager em = factory.createEntityManager();
        Query query = em.createNamedQuery("Comments.findAll");

        List<Comments> commentsList = new ArrayList<Comments>();
        commentsList = query.getResultList();
        return commentsList;
    }

    public static List<Comments> getCommentsByRouteId(int routeId) throws Exception {
        EntityManager em = factory.createEntityManager();
        Route route = new Route();
        route = getRouteById(routeId);
        Query query = em.createNamedQuery("Comments.findByRouteId");
        query.setParameter("routeId", routeId);
        List<Comments> commentsList = new ArrayList<Comments>();
        commentsList = query.getResultList();
        return commentsList;
    }

    public static User getUserByEmailAndPassword(String email, String password) throws Exception {
        User user = new User();
        EntityManager em = factory.createEntityManager();
        Query query = em.createNamedQuery("User.login");
        query.setParameter("email", email);
        query.setParameter("password", password);
        user = (User) query.getSingleResult();
        return user;
    }

    public static void updateRouteVotes(RouteVotes routeVote) throws Exception {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();
        em.merge(routeVote);
        em.getTransaction().commit();
        em.close();
    }

    public static boolean addRouteVotes(RouteVotes routeVote) throws Exception {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();
        em.persist(routeVote);
        em.getTransaction().commit();
        em.close();
        return false;
    }
    
    public static boolean addCommentOnRoute(Comments comment) throws Exception {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();
        em.persist(comment);
        em.getTransaction().commit();
        em.close();
        return false;
    }
    
    public static boolean addRoute(Route route) throws Exception {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();
        em.persist(route);
        em.getTransaction().commit();
        em.close();
        return false;
    }
    
}
