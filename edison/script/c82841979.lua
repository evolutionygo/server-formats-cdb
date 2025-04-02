--大和神
--Yamato-no-Kami
function c82841979.initial_effect(c)
	c:EnableReviveLimit()
	Spirit.AddProcedure(c,EVENT_SPSUMMON_SUCCESS)
	--Cannot be Special Summoned
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Special Summon procedure
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c82841979.spcon)
	e2:SetTarget(c82841979.sptg)
	e2:SetOperation(c82841979.spop)
	c:RegisterEffect(e2)
	--Destroy 1 Spell/Trap card
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc82841979(c82841979,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(aux.bdocon)
	e3:SetTarget(c82841979.destg)
	e3:SetOperation(c82841979.desop)
	c:RegisterEffect(e3)
end
c82841979.listed_card_types={TYPE_SPIRIT}
function c82841979.spfilter(c,tp)
	return c:IsType(TYPE_SPIRIT) and c:IsAbleToRemoveAsCost()
		and aux.SpElimFilter(c,true) and Duel.GetMZoneCount(tp,c)>0
end
function c82841979.spcon(e,c)
	if c==nil then return true end
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c82841979.spfilter,tp,LOCATION_MZONE|LOCATION_GRAVE,0,1,nil,tp)
end
function c82841979.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c82841979.spfilter,tp,LOCATION_MZONE|LOCATION_GRAVE,0,1,1,nil,tp)
	if #g==0 then return false end
	e:SetLabelObject(g:GetFirst())
	return true
end
function c82841979.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=e:GetLabelObject()
	if tc then
		Duel.Remove(tc,POS_FACEUP,REASON_COST)
	end
end
function c82841979.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsSpellTrap() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c82841979.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end