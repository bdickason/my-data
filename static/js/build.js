
/**
 * Require the given path.
 *
 * @param {String} path
 * @return {Object} exports
 * @api public
 */

function require(path, parent, orig) {
  var resolved = require.resolve(path);

  // lookup failed
  if (null == resolved) {
    orig = orig || path;
    parent = parent || 'root';
    var err = new Error('Failed to require "' + orig + '" from "' + parent + '"');
    err.path = orig;
    err.parent = parent;
    err.require = true;
    throw err;
  }

  var module = require.modules[resolved];

  // perform real require()
  // by invoking the module's
  // registered function
  if (!module.exports) {
    module.exports = {};
    module.client = module.component = true;
    module.call(this, module.exports, require.relative(resolved), module);
  }

  return module.exports;
}

/**
 * Registered modules.
 */

require.modules = {};

/**
 * Registered aliases.
 */

require.aliases = {};

/**
 * Resolve `path`.
 *
 * Lookup:
 *
 *   - PATH/index.js
 *   - PATH.js
 *   - PATH
 *
 * @param {String} path
 * @return {String} path or null
 * @api private
 */

require.resolve = function(path) {
  if (path.charAt(0) === '/') path = path.slice(1);

  var paths = [
    path,
    path + '.js',
    path + '.json',
    path + '/index.js',
    path + '/index.json'
  ];

  for (var i = 0; i < paths.length; i++) {
    var path = paths[i];
    if (require.modules.hasOwnProperty(path)) return path;
    if (require.aliases.hasOwnProperty(path)) return require.aliases[path];
  }
};

/**
 * Normalize `path` relative to the current path.
 *
 * @param {String} curr
 * @param {String} path
 * @return {String}
 * @api private
 */

require.normalize = function(curr, path) {
  var segs = [];

  if ('.' != path.charAt(0)) return path;

  curr = curr.split('/');
  path = path.split('/');

  for (var i = 0; i < path.length; ++i) {
    if ('..' == path[i]) {
      curr.pop();
    } else if ('.' != path[i] && '' != path[i]) {
      segs.push(path[i]);
    }
  }

  return curr.concat(segs).join('/');
};

/**
 * Register module at `path` with callback `definition`.
 *
 * @param {String} path
 * @param {Function} definition
 * @api private
 */

require.register = function(path, definition) {
  require.modules[path] = definition;
};

/**
 * Alias a module definition.
 *
 * @param {String} from
 * @param {String} to
 * @api private
 */

require.alias = function(from, to) {
  if (!require.modules.hasOwnProperty(from)) {
    throw new Error('Failed to alias "' + from + '", it does not exist');
  }
  require.aliases[to] = from;
};

/**
 * Return a require function relative to the `parent` path.
 *
 * @param {String} parent
 * @return {Function}
 * @api private
 */

require.relative = function(parent) {
  var p = require.normalize(parent, '..');

  /**
   * lastIndexOf helper.
   */

  function lastIndexOf(arr, obj) {
    var i = arr.length;
    while (i--) {
      if (arr[i] === obj) return i;
    }
    return -1;
  }

  /**
   * The relative require() itself.
   */

  function localRequire(path) {
    var resolved = localRequire.resolve(path);
    return require(resolved, parent, path);
  }

  /**
   * Resolve relative to the parent.
   */

  localRequire.resolve = function(path) {
    var c = path.charAt(0);
    if ('/' == c) return path.slice(1);
    if ('.' == c) return require.normalize(p, path);

    // resolve deps by returning
    // the dep in the nearest "deps"
    // directory
    var segs = parent.split('/');
    var i = lastIndexOf(segs, 'deps') + 1;
    if (!i) i = 0;
    path = segs.slice(0, i + 1).join('/') + '/deps/' + path;
    return path;
  };

  /**
   * Check if module is defined at `path`.
   */

  localRequire.exists = function(path) {
    return require.modules.hasOwnProperty(localRequire.resolve(path));
  };

  return localRequire;
};
require.register("visionmedia-page.js/index.js", function(exports, require, module){
�      �YYs�F~��iS ɠ\�'ڊ�8q�ʖ��Q�@)K���A�@+k�~}�� $g7U��������{=�|V�EF��3:8��������(�&��:M23O�MR�V1o��2)��91u��O;g��T� ��tA�'&����y��K�Ȓe�L)[=x�L�ږfJ4��*�Wf�d�E2�l��iz$�)JS��*�����6�꤬(ڀ��y���Gfwu��l9�s�fE2?2������n���T�ڎMP�p���}������MR&ks��.qڗW��;�@��[�q,W7ϓMj6ۋ,�5:v�!��X��@�hd�9��+��C
�	��fc�3�Ќ)m�-s9����,msG6�g�ʞ����.ZL�^ä��ubr{eޓ)�-����MH��0�<şg&)�۵��*�l��WO��a��A�$v���ͶZ�L'^��yf��҆��Iz���z�jU\�"�Y�s��\��Z�Z��X3N��5vJ�d#7�bC�^u�E�]�:�P}������Sr�rU�����w]�g[��U�CA�(�b��p��v��c�Cfʄ5�����������:��)�؟Cشp׋ii>�HS��Y��67Sl�oE�c�%��4��Lgp��SsA���i,Ω+3� ��qЛb�� ��`��fsO�n#	'����Y}g�.�y��ŤN�������&�~}�bn!KiC#���l��O&x���@zZ�n�3�5$k���DA��������'���)�����T���DG����g�8���T��{�^s'	�r6��n�dfì�%��1Yg��-҉_�lR����6ˎ8y�0�=S����&��-��Ѭ���R��Ql��v=A�kT��Ni�ť�I�Ab|UW��X+�F\X�	��T}�`'���H��s>��S?Ef��ΫA�5�ݾ,��^ל���m�J�g�-K��$6��N�N)hN`�A+nl�	��'����os1�yDt8�}�sC��ao��ދ!���ߊY��^IS-�?˛dE�t�ӄ)rWJM�!M�j��%�R%�N?jMoZ�&bg��o[k�^:�瞠c=mA�!5JU�1'V�^Z��^�Q�ki)U�"`�������*S2��z�jo�-���>A�[d
�;�����$b��B�O��2yQ���3i�Љ���Ӓ�y�07�Ѧ�BG<GP�;��B6���W9�Ҕ�\�:�ۛ�t�B��C
����F�L�LS�Pj�oI�!c%;�%y��`�Z��VҪ�b���{��Ʈ{4��s6���Y���4��5	ǹ�����U�o�*��H�k��}s�i(����Z\M=�M^C���`�%>�99>7�~k�͞|#|����EHj1����!��]C+'8���lV]ݱ�9l�֣�W{�#4��A)6���i�QG?/f�1�B� �o�dt^m�laB����>��wjN�׸Be���mv���]��#�n�{_����a��Oכ�\�V���u`��n��	R.ޱ,6�~���MY�u�Mz����
���򦕂q� ����]z�8�WfR���uoF��4e��U���ᯱ�
Sn�u�x�/?�sc		��I�V�LnFS߱J`�j���v�\e�
�K�?�'��\��ߑ9F%Ĺ${�Ռ� ɢYӔ��`h��2I3����ZY9C�}g�34��utb}Ze�χ�f6�VEZX�����a���k[��9�!����m?-��^S�@[���KU�"���~�7��~ٵ�^ƻ;,bi{:��y�XKߗy�����gV2Hj<�I�J��M!�R�+?�[��QW��-]�'�`+N�j
�F�,�	���iJ���|Xi�$A����b�J��8L�8�_4���9�e�ѢN�Q��k�^�,�(C�+'[�e+?��nU�(Pfm3J%S!>X�� t�#^���1�����2�{ɎЉ�v���`ɫ���oV	���k����d�a����w� r�����qתo$q���^�;�G8R��n�(S���E1�Fq{b�~ JcR��&�dl�& 鲓!���LڽDύx�;�\cJ������s������zS�(-B��<��з^D���!-){�՘.}�[�|��v�ʊ�O��M<�9�[�aìeR���!:Uf���~uƭ�����o���K�Q����2���iCΠ���p��@ե�*�mt��"7v��o�d>L����\�MUٹ�w�Ja�W)�R*�4g�<Z�ܖ|$+�Z��2��N���}��χ0wE���~:�?����� a��w�������K�������#�Nj�!�=w�W(w2� �S�N�:b{?B�՚ ?%�
|�`����g�0"��Ѷ�e���+� ��$��/�<��8?4A�I��%��Q��&�������x�9p�������x:��g��4<���qxvu,<��ӳ(������}v�'�AU�Ȱ1I����� ���p��f,
$Nq�[����8ȱ��k�8}=#<!��3A�WT$����������*�m"�!����c	1�E�X��W� �zgZq�h��p��(>?<���O�B�e���/_�	0��'g87be��}�d@�g��� �:�?��?��o�ވ�o0�hj\gJ���B�/<J6�.���G���nՌ�C�9���b|����'.$w��qd��r�S:6y�0��e�	5�>�ޝ��(��_6�0<��e�?�U���5��\�l��]�Sy����&=<�!�����l"�a-%X��oiu�֠�;dl/b�fq�����ɨ��7Xo"������aá�+��giUZ�?A�~��Ī�!����iS�!:w�OI��۽�d/�I7���]�,��D�)�`~X!��g��qQ�˔s��*H�-��Dd�A�.K~`�����;Vi.��H�%��x�ҟ��G�7g��!!�?��iծ8๭�>g��e�YR��阦p�aԍ�m̨�Na{BD�X` B��|0%�N�8X����0�W�2�䎲��y�yʬ�(n�0ak�������҈���e)��긃��vG��Lw����?��)����a=�]�>m�����6��O�A�laK��S�
J~���g���]D�'�z��#  
});
require.register("boot/boot.js", function(exports, require, module){
// Generated by CoffeeScript 1.6.3
(function() {
  var page;

  page = require('page');

  console.log(page);

}).call(this);

});
require.alias("boot/boot.js", "my-data/deps/boot/boot.js");
require.alias("boot/boot.js", "my-data/deps/boot/index.js");
require.alias("boot/boot.js", "boot/index.js");
require.alias("visionmedia-page.js/index.js", "boot/deps/page/index.js");

require.alias("boot/boot.js", "boot/index.js");

