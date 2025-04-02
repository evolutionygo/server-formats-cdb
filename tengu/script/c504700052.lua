--奈落の落とし穴
--Bottomless Trap Hole (GOAT)
--It affects all the monsters summoned during the current chain
function c504700052.initial_effect(c)
	local g=Group.CreateGroup()
	g:KeepAlive()
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetLabelObject(g)
	e1:SetTarget(c504700052.target)
	e1:SetOperation(c504700052.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e2:SetLabelObject(g)
	e2:SetTarget(c504700052.target)
	e2:SetOperation(c504700052.activate)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetLabelObject(g)
	e3:SetTarget(c504700052.target2)
	e3:SetOperation(c504700052.activate2)
	c:RegisterEffect(e3)
end
function c504700052.filter(c,tp,ep)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:GetAttack()>=1500
		and ep~=tp and c:IsAbleToRemove()
end
function c504700052.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return c504700052.filter(tc,tp,ep) end
	e:GetLabelObject():Clear()
	e:GetLabelObject():Merge(Duel.GetFieldGroup(tp,0,LOCATION_MZONE)+eg)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tc,1,0,0)
end
function c504700052.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local g=Duel.GetMatchingGroup(c504700052.filter2,tp,0,LOCATION_MZONE,e:GetLabelObject(),tp)
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetAttack()>=1500 then
		g:AddCard(tc)
	end
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT,LOCATION_REMOVED)
	end
end
function c504700052.filter2(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsStatus(STATUS_SUMMON_TURN|STATUS_FLIP_SUMMON_TURN|STATUS_SPSUMMON_TURN)
		and c:GetAttack()>=1500 and c:GetSummonPlayer()~=tp and c:IsAbleToRemove()
end
function c504700052.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c504700052.filter2,1,nil,tp) end
	local g=eg:Filter(c504700052.filter2,nil,tp)
	e:GetLabelObject():Clear()
	e:GetLabelObject():Merge(Duel.GetFieldGroup(tp,0,LOCATION_MZONE)+g)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,#g,0,0)
end
function c504700052.filter3(c,e,tp)
	return c:IsFaceup() and c:GetAttack()>=1500 and not c:IsSummonPlayer(tp)
		and c:IsRelateToEffect(e) and c:IsLocation(LOCATION_MZONE)
end
function c504700052.activate2(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c504700052.filter3,nil,e,tp)+Duel.GetMatchingGroup(c504700052.filter2,tp,0,LOCATION_MZONE,e:GetLabelObject(),tp)
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT,LOCATION_REMOVED)
	end
end