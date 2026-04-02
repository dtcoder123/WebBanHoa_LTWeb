using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebBanHoa.App_Start
{
    public static class SessionHelper
    {
        public static bool IsLoggedIn(this HttpSessionStateBase session)
        {
            return session["UserID"] != null;
        }

        // 2. Lấy Role của người dùng
        public static string GetUserRole(this HttpSessionStateBase session)
        {
            return session["UserRole"] as string;
        }

        // 3. Kiểm tra có phải Admin không
        public static bool IsAdmin(this HttpSessionStateBase session)
        {
            return session.GetUserRole() == "Admin";
        }
    }
}