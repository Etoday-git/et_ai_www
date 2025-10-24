<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>MySQL 테이블 정의서</title>
</head>
<body>
    <h1>📘 MySQL 테이블 정의서</h1>
    <?php foreach ($schema as $table_name => $columns): ?>
    <?php
        $table_comment = '';
        foreach ($tables as $tbl) {
            if ($tbl['name'] === $table_name) {
                $table_comment = $tbl['comment'];
                break;
            }
        }
        ?>
    <h3><?= $table_name ?></h3>
    <style type="text/css">
        .tg  {border-collapse:collapse;border-spacing:0;}
        .tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:13px;
        overflow:hidden;padding:10px 5px;word-break:normal;}
        .tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:13px;
        font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
        .tg .tg-18eh{border-color:#000000;font-weight:bold;text-align:center;vertical-align:middle}
        .tg .tg-jqlm{background-color:#DAEEF3;border-color:#000000;font-weight:bold;text-align:center;vertical-align:middle}
        .tg .tg-cpjw{background-color:#DAEEF3;border-color:#000000;font-weight:bold;text-align:left;vertical-align:middle}
        .tg .tg-prm3{background-color:#D9D9D9;border-color:#000000;font-weight:bold;text-align:center;vertical-align:middle}
        .tg .tg-1tol{border-color:#000000;font-weight:bold;text-align:left;vertical-align:middle}
        .tg .tg-0a7q{border-color:#000000;text-align:left;vertical-align:middle}
        .tg .tg-xwyw{border-color:#000000;text-align:center;vertical-align:middle}
        </style>
        <table class="tg">
            <thead>
                <tr>
                    <th class="tg-prm3">테이블 ID</th>
                    <th class="tg-18eh"><?= $table_name ?></th>
                    <th class="tg-prm3" colspan="3">테이블 명</th>
                    <th class="tg-1tol"></th>
                </tr>
                <tr>
                    <th class="tg-prm3">서브시스템</th>
                    <th class="tg-18eh"></th>
                    <th class="tg-prm3" colspan="3">설명</th>
                    <th class="tg-1tol"><?= $table_comment ?></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="tg-cpjw">Field</td>
                    <td class="tg-jqlm">Type</td>
                    <td class="tg-jqlm">Null</td>
                    <td class="tg-jqlm">PK</td>
                    <td class="tg-jqlm">default</td>
                    <td class="tg-cpjw">Comment</td>
                </tr>
                <?php foreach ($columns as $column): ?>

                <tr>
                    <td class="tg-0a7q"><?= $column['Field'] ?></td>
                    <td class="tg-xwyw"><?= $column['Type'] ?></td>
                    <td class="tg-xwyw"><?= $column['Null'] ?></td>
                    <td class="tg-xwyw"><?= ($column['Key'] === 'PRI') ? 'YES' : '' ?></td>
                    <td class="tg-xwyw"><?= $column['Default'] ?></td>
                    <td class="tg-0a7q"><?= $column['Comment'] ?></td>
                </tr>
                <?php endforeach; ?>

            </tbody>
        </table>
        <?php endforeach; ?>
</body>
</html>