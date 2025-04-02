--ブラック・マジシャン・ガール
--Dark Magician Girl (Rush)
function c160411002.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c160411002.val)
	c:RegisterEffect(e1)
end
c160411002.listed_names={CARD_DARK_MAGICIAN}
function c160411002.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil,CARD_DARK_MAGICIAN)*500
end