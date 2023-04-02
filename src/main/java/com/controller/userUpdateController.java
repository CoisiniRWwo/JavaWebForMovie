package com.controller;

import com.DaoFactory.DaoFactory;
import com.bean.User;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.*;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

/**
 * @Author:Su HangFei
 * @Date:2022-12-02 22 35
 * @Project:JavaWebEndofPeriod
 */
@WebServlet("/userUpdateController")
public class userUpdateController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "headUrl";
    // 上传配置
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String action = request.getParameter("action");
        if (action.equals("user_update")){
            try {
                userUpdate(request,response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else if (action.equals("delete")){
            try {
                userdelete(request,response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else if(action.equals("download")){
            try {
                download(request,response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else if (action.equals("deleteAll")){
            try {
                deleteAll(request,response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    public void userUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String url = this.getClass().getClassLoader().getResource("").getPath();
        String[] urls = url.split("WEB-INF");
        String[] str = new String[10];
        HttpSession session = request.getSession();

        if (!ServletFileUpload.isMultipartContent(request)) {
            request.setAttribute("msg", "Error: 表单必须包含 enctype=multipart/form-data！");
            request.setAttribute("url", "user_userManagement.jsp");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
        try {
            //设置ContentType字段值
            response.setContentType("text/html;charset=utf-8");
            // 创建DiskFileItemFactory工厂对象
            DiskFileItemFactory factory = new DiskFileItemFactory();
            // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
            factory.setSizeThreshold(MEMORY_THRESHOLD);
            //设置文件缓存目录，如果该目录不存在则新创建一个
            String fileUrl = urls[0] + UPLOAD_DIRECTORY;
            File f = new File(fileUrl);
            if (!f.exists()) f.mkdirs();
            // 设置文件的缓存路径
            factory.setRepository(f);
            // 创建 ServletFileUpload对象
            ServletFileUpload fileupload = new ServletFileUpload(factory);
            //设置字符编码
            fileupload.setHeaderEncoding("utf-8");
            //设置字符编码,中文处理
            fileupload.setHeaderEncoding("utf-8");
            // 设置最大文件上传值
            fileupload.setFileSizeMax(MAX_FILE_SIZE);
            // 设置最大请求值 (包含文件和表单数据)
            fileupload.setSizeMax(MAX_REQUEST_SIZE);
            // 解析 request，得到上传文件的FileItem对象
            ServletRequestContext src = new ServletRequestContext(request);
            List<FileItem> fileitems = fileupload.parseRequest(src);

            // 遍历集合
            for (int i = 0; i < fileitems.size(); i++) {
                // 判断是否为普通字段
                if (fileitems.get(i).isFormField()) {
                    // 获得字段名和字段值
                    String name = fileitems.get(i).getFieldName();
                    if (i != 1 && i != 2) {
                        //如果文件不为空，将其保存在value中
                        if (!fileitems.get(i).getString().equals("")) {
                            str[i] = fileitems.get(i).getString("utf-8");
                        }
                    }
                } else {
                    // 获取上传的文件名
                    String filename = fileitems.get(i).getName();
                    if (filename.equals("")) {
                        str[i] = fileitems.get(1).getString("utf-8");
                        continue;
                    }
                    String fi = filename.substring(filename.lastIndexOf(".") + 1);
                    if (!fi.equals("png") && !fi.equals("jpg") && !fi.equals("gif") && !fi.equals("bmp")) {
                        request.setAttribute("msg", "请上传有效的图片！(png,jpg,gif,bmp)");
                        request.setAttribute("url", "user_userManagement.jsp");
                        request.getRequestDispatcher("result.jsp").forward(request, response);
                        return;
                    }
                    //处理上传文件
                    if (filename != null && !filename.equals("")) {
                        // 截取出上传文件名
                        filename = filename.substring(filename.lastIndexOf("\\") + 1);
                        // 文件名需要唯一
                        filename = UUID.randomUUID() + "_" + filename;
                        //将服务器中文件夹路径与文件名组合成完整的服务器端路径
                        String filepath = fileUrl + "\\" + filename;
                        // 创建文件
                        File file = new File(filepath);
                        file.getParentFile().mkdirs();
                        file.createNewFile();
                        str[i] = "headUrl/" + filename;
                        // 获得上传文件流
                        InputStream in = fileitems.get(i).getInputStream();
                        // 使用FileOutputStream打开服务器端的上传文件
                        FileOutputStream out = new FileOutputStream(file);
                        // 流的对拷
                        byte[] buffer = new byte[1024];//每次读取1个字节
                        int len;
                        //开始读取上传文件的字节，并将其输出到服务端的上传文件输出流中
                        while ((len = in.read(buffer)) > 0)
                            out.write(buffer, 0, len);
                        // 关闭流
                        in.close();
                        out.close();
                        // 删除临时文件
                        fileitems.get(i).delete();
                    }
                }
            }
            session.setAttribute("username", str[3]);
            User user = new User(Integer.parseInt(str[0]), str[3], str[4], str[5], str[7], str[6], str[8], str[2], str[9]);
            boolean result = DaoFactory.getUserDaoInstance().updateUser(user);
            if (result) {
                request.setAttribute("msg", "修改成功！");
                request.setAttribute("url", "user_userManagement.jsp");
                request.getRequestDispatcher("result.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "修改失败！");
                request.setAttribute("url", "user_userManagement.jsp");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void userdelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String id = request.getParameter("id");
        int idnumber = 0;
        if (id != null && !id.trim().equals("")) {
            idnumber = Integer.parseInt(id.trim());
        }
        boolean result = DaoFactory.getCollectionDaoInstance().delete(idnumber);
        if (result) {
            request.setAttribute("msg", "删除成功！");
            request.setAttribute("url", "user_userHomepage.jsp");
            request.getRequestDispatcher("result.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "删除失败！");
            request.setAttribute("url", "user_userHomepage.jsp");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    public void download(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //设置ContentType字段值
        response.setContentType("text/html;charset=utf-8");
        //设置相应消息编码
        response.setCharacterEncoding("utf-8");
        //设置请求消息编码
        request.setCharacterEncoding("utf-8");
        //获取所要下载的文件名称
        String filenameurl = request.getParameter("filename");
        String filename = filenameurl.substring(filenameurl.lastIndexOf("/") + 1);
        String[] str = filenameurl.split("/");
        System.out.println(str[0]);
        //对文件名称编码
        filename = new String(filename.trim().getBytes("ISO-8859-1"),"UTF-8");
        //下载文件所在目录
        String folder = str[0];
        System.out.println(folder);
        // 通知浏览器以下载的方式打开
        response.addHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode(filename,"utf-8"));
        response.addHeader("Content-Type", "application/octet-stream;charset=utf-8");
        // 通过文件流读取文件
        InputStream in = getServletContext().getResourceAsStream(folder + "/" + filename);
        // 获取response对象的输出流
        OutputStream out = response.getOutputStream();
        byte[] buffer = new byte[1024];
        int len;
        //循环取出流中的数据
        while ((len = in.read(buffer)) != -1) {
            out.write(buffer, 0, len);
        }
    }

    public void deleteAll(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String[] ids = request.getParameterValues("checkAll");
        String condition = "";
        for(int i = 0; i < ids.length; i++){
            condition += ids[i];
            if(i != ids.length - 1) condition += ",";
        }
        boolean result = DaoFactory.getCollectionDaoInstance().deleteAll(condition);
        if (result) {
            request.setAttribute("msg", "删除成功！");
            request.setAttribute("url", "user_userHomepage.jsp");
            request.getRequestDispatcher("result.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "删除失败！");
            request.setAttribute("url", "user_userHomepage.jsp");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
