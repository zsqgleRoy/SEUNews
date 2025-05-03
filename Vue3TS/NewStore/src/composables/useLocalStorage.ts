import { ref, watch } from 'vue';

export const useLocalStorage = <T>(key: string, initialValue: T) => {
    let storedValue: T | null = null;
    try {
        const item = localStorage.getItem(key);
        if (item) {
            storedValue = JSON.parse(item);
        }
    } catch (error) {
        console.error(`Error parsing localStorage value for key "${key}":`, error);
    }

    const value = ref(storedValue !== null ? storedValue : initialValue);

    watch(value, (newValue) => {
        try {
            localStorage.setItem(key, JSON.stringify(newValue));
        } catch (error) {
            console.error(`Error setting localStorage value for key "${key}":`, error);
        }
    }, { deep: true });

    return {
        value
    };
};
