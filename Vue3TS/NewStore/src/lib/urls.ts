

export interface URL{
    BASE_URL:string;
    LOCAL_PORT:number;
    LOCAL_URL:string;
    SERVER_PORT:number;
    SERVER_URL:string;
}

// 定义初始状态变量
export const initialURL: URL = {
    BASE_URL:"http://localhost",
    LOCAL_PORT:4567,
    LOCAL_URL:"http://localhost:4567",
    SERVER_PORT:8080,
    SERVER_URL:"http://seunewsbac.pgrm.cc"
};

// 定义初始状态变量
export const productURL: URL = {
    BASE_URL:"localhost",
    LOCAL_PORT:4567,
    LOCAL_URL:"localhost:4567",
    SERVER_PORT:8080,
    SERVER_URL:"localhost:8080"
};