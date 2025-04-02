--幻魔帝トリロジーグ (Manga)
--Phantasm Emperor Trilojig (Manga)
--Updated by Larry126 and MLD
local s,c511009001,alias=GetID()
function c511009001.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2N(c,false,false,aux.FilterBoolFunction(Card.IsLevel,10),3)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511009001(alias,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511009001.damcon)
	e1:SetTarget(c511009001.damtg)
	e1:SetOperation(c511009001.damop)
	c:RegisterEffect(e1)
end
function c511009001.filter(c,tp)
	return c:IsPreviousLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c511009001.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009001.filter,1,nil,tp)
end
function c511009001.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:HasNonZeroAttack() end
	if chk==0 then return Duel.IsExistingTarget(Card.HasNonZeroAttack,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.HasNonZeroAttack,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511009001.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:HasNonZeroAttack() and tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,tc:GetAttack()//2,REASON_EFFECT)
	end
end