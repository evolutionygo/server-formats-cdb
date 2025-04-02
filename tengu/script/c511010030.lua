--No.30 破滅のアシッド・ゴーレム (Anime)
--Number 30: Acc511010030 Golem of Destruction (Anime)
Duel.LoadCardScript("c81330115.lua")
function c511010030.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon Procedure
	aux.AddXyzProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_LIGHT),3,2)
	--Detach 1 material from this card or take 2000 damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511010030(c511010030,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(function(e,tp) return Duel.IsTurnPlayer(tp) end)
	e1:SetTarget(c511010030.rmtg)
	e1:SetOperation(c511010030.rmop)
	c:RegisterEffect(e1)
	--Cannot attack while it has no materials
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(function(e) return e:GetHandler():GetOverlayCount()==0 end)
	c:RegisterEffect(e2)
	--Destroy this card and take 2000 damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511010030(c511010030,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetCondition(function(e) return e:GetHandler():GetOverlayCount()==0 end)
	e3:SetTarget(c511010030.oltg)
	e3:SetOperation(c511010030.olop)
	c:RegisterEffect(e3)
	--Cannot be destroy by battle with non-"Number" monsters
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(function(e,cc) return not cc:IsSetCard(SET_NUMBER) end)
	c:RegisterEffect(e4)
end
c511010030.aux.xyz_number=30
c511010030.listed_series={SET_NUMBER}
function c511010030.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:GetHandler():GetOverlayCount()==0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,2000)
	end
end
function c511010030.rmop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) and Duel.SelectYesNo(tp,aux.Stringc511010030(81330115,1)) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	else
		Duel.Damage(tp,2000,REASON_EFFECT)
	end
end
function c511010030.oltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,2000)
end
function c511010030.olop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)>0 then
		Duel.Damage(tp,2000,REASON_EFFECT)
	end
end