--氷結界の龍 グングニール
--Gungnir, Dragon of the Ice Barrier
function c65749035.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTunerEx(Card.IsAttribute,ATTRIBUTE_WATER),1,99)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc65749035(c65749035,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c65749035.cost)
	e1:SetTarget(c65749035.target)
	e1:SetOperation(c65749035.operation)
	c:RegisterEffect(e1)
end
function c65749035.costfilter(c)
	return c:IsAbleToGraveAsCost()
end
function c65749035.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local rt=math.min(2,Duel.GetTargetCount(aux.TRUE,tp,0,LOCATION_ONFIELD,nil))
	if chk==0 then return aux.IceBarrierDiscardCost(c65749035.costfilter,true,1,rt)(e,tp,eg,ep,ev,re,r,rp,0) end
	e:SetLabel(aux.IceBarrierDiscardCost(c65749035.costfilter,true,1,rt)(e,tp,eg,ep,ev,re,r,rp,1))
end
function c65749035.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local ct=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local eg=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,ct,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,ct,0,0)
end
function c65749035.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg=Duel.GetTargetCards(e)
	if #rg>0 then 
		Duel.Destroy(rg,REASON_EFFECT)
	end
end