package routing

import (
	"net/http"
	"path"
	"strings"
)

type NormalizedServeMux struct {
	*http.ServeMux
}

func NewNormalizedServeMux() *NormalizedServeMux {
	return &NormalizedServeMux{http.NewServeMux()}
}

func (nm *NormalizedServeMux) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if strings.Contains(r.URL.Path, "//") {
		normalizedPath := path.Clean(r.URL.Path)
		r.URL.Path = normalizedPath
	}

	nm.ServeMux.ServeHTTP(w, r)
}
