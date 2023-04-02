package com.DaoFactory;

import com.Dao.*;
import com.Dao.Imp.*;

/**
 * @Author:Su HangFei
 * @Date:2022-11-29 15 19
 * @Project:JavaWebEndofPeriod
 */
public class DaoFactory {

    public static MovieDao getMovieDaoInstance() {
        return new MovieDaoImp();
    }

    public static UserDao getUserDaoInstance() {
        return new UserDaoImp();
    }

    public static CollectionDao getCollectionDaoInstance() {
        return new CollectionDaoImp();
    }

    public static UserRecommendationDao getUserRecommendationDaoInstance() {
        return new UserRecommendationImp();
    }

    public static CommentsDao getCommentsDaoInstance() {
        return new CommentsDaoImp();
    }

    public static MoviesimilarDao getMoviesImilarDaoInstance() {
        return new MoviesimilarDaoImp();
    }

}
