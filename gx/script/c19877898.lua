--アルティメット・インセクト LV7
--Ultimate Insect LV7
function c19877898.initial_effect(c)
	--atk,def down
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCondition(c19877898.con)
	e1:SetValue(-700)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
c19877898.listed_names={34830502}
c19877898.LVnum=7
c19877898.LVset=0x5d
function c19877898.con(e)
	return e:GetHandler():GetFlagEffect(c19877898)~=0
end